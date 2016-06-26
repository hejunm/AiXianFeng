//
//  HESearchVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/18.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESearchVC: HEAnimationController {
    
    private var searchBar:UISearchBar!
    private var searchView:HESearchView!
    private var searchResultView:HESearchResultCollectionView!
    private var shopCarView:HEYellowShopCarView!
    private var searchResultArray:[Goods]?{
        didSet{
            if searchResultArray == nil{ return }
            searchResultView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HEGlobalBackgroundColor
        buildSearchBar()
        buildSearchView()
        buildSearchResultView()
        buildYellowShopCarView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        shopCarView.frame = CGRectMake(view.width-80,view.height-NavigationH-80,60,60)
    }
    // MARK: - Build UI
    private func buildSearchBar(){
        let tmpView = UIView(frame: CGRectMake(0, 0, ScreenWidth * 0.8, 30))
        tmpView.backgroundColor = UIColor.whiteColor()
        tmpView.layer.masksToBounds = true
        tmpView.layer.cornerRadius = 6
        tmpView.layer.borderColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1).CGColor
        tmpView.layer.borderWidth = 0.2
        let image = UIImage.createImageFromView(tmpView)
        
        searchBar=UISearchBar()
        searchBar.size = CGSizeMake(ScreenWidth * 0.9, 30)
        searchBar.placeholder = "请输入商品名称"
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.keyboardType = UIKeyboardType.Default
        searchBar.setSearchFieldBackgroundImage(image, forState: .Normal)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func buildSearchView() {
        searchView = HESearchView(frame: view.bounds)
        searchView.height -= NavigationH
        searchView.alwaysBounceVertical = true
        searchView.delegate = self
        searchView.searchDelegate = self
        view.addSubview(searchView)
    }
    
    //显示搜索结果的collectionView
    private func buildSearchResultView(){
        searchResultView = HESearchResultCollectionView(frame: view.bounds)
        searchResultView.height -= NavigationH
        searchResultView.backgroundColor = view.backgroundColor
        searchResultView.hidden = true
        searchResultView.dataSource = self
        searchResultView.delegate = self
        searchResultView.registerClass(HEHomeVerticalCell.self, forCellWithReuseIdentifier: HEHomeVerticalCell.Id)
        view.addSubview(searchResultView)
    }
    
    private func buildYellowShopCarView(){
        shopCarView = HEYellowShopCarView()
        shopCarView.hidden = true
        shopCarView.addTarget(self, action: #selector(HESearchVC.showShopCarVC), forControlEvents: .TouchUpInside)
        view.addSubview(shopCarView)
    }
    
    @objc private func showShopCarVC(){
        //购物车对应导航控制器
        let  shopCarNavi = HEBaseNavigationController(rootViewController: HEShopCarViewController())
        presentViewController(shopCarNavi, animated: true, completion: { }) //显示出导航控制器
    }
}

extension HESearchVC:UISearchBarDelegate{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text != nil && searchBar.text!.characters.count != 0{ //开始搜索
            HEQueryHistoryModel.shareInstance().append(searchBar.text!)
            searchWith(searchBar.text!)
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count==0 {
            searchView.hidden = false
            searchResultView.hidden = true
            shopCarView.hidden = true
        }
    }
}

//extension HESearchView:
extension HESearchVC:UIScrollViewDelegate{
    
}

extension HESearchVC:HESearchViewDelegate{
    func searchWith(keyWord: String) {
        searchBar.resignFirstResponder()
        view.endEditing(true)
        searchBar.text = keyWord
        
        ProgressHUD.setBackgroundColor(UIColor.whiteColor())
        ProgressHUD.showWithStatus("正在全力加载")
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            ProgressHUD.dismiss()
            //显示出加载出来的数据
            tmpSelf!.searchView.hidden = true
            tmpSelf!.searchResultView.hidden = false
            tmpSelf!.shopCarView.hidden = false
            HESearchProcducts.loadData({ (data, error) in
                if data != nil{
                    tmpSelf!.searchResultArray = data.data
                    tmpSelf!.searchResultView.headerView.setSearchProductLabelText(keyWord)
                }
            })
        }
    }
}

extension HESearchVC:UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return searchResultArray?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HEHomeVerticalCell", forIndexPath: indexPath) as! HEHomeVerticalCell
        cell.goods = searchResultArray?[indexPath.row]
        
        weak var tmpSelf = self
        cell.addGoodsToShopCerAnim({ (imageView) -> () in //添加商品时的动画
            tmpSelf?.addProductsAnimation(imageView)
        })
        return cell
    }
}

extension HESearchVC:UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((view.width - HEHomeCollectionViewCellMargin * 2) * 0.5 - HEHomeCollectionViewCellMargin/2, 250)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let productDetailVC = HEProductDetailVC(goods: (searchResultArray?[indexPath.row])!)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
