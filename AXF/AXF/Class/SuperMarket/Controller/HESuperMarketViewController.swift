//
//  SuperMarketViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  闪电超市

import UIKit

class HESuperMarketViewController: HESelectedAdressViewController {
    
    //MARK:property
    var categoryTableView:HETableView!
    var productsVC:HEProductViewController!
    var superMarketData:HESuperMarket?{  //数据
        didSet{
            if superMarketData == nil{
                return
            }
           productsVC.superMarketData = superMarketData
           categoryTableView.reloadData()
        }
    }
    
    
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showProgressHUD()
        buildCategoryTableView()
        buildProductsVC()
    }
    
    //MARK: private func
    private func buildCategoryTableView(){
        categoryTableView = HETableView(frame: CGRectMake(0, 0, view.width*0.25, view.height-NavigationH), style: .Plain)
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.rowHeight = 45
        categoryTableView.backgroundColor = HEGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        view.addSubview(categoryTableView)
    }
    
    private func buildProductsVC(){
        productsVC = HEProductViewController()
        productsVC.delegate = self
        addChildViewController(productsVC) //"willMoveToParentViewController" is called for us
        view.addSubview(productsVC.view)
        productsVC.didMoveToParentViewController(self)
    }
    
    // MARK: - 加载数据指示器
    private func showProgressHUD() {
        ProgressHUD.setBackgroundColor(UIColor.colorWithCustom(230, g: 230, b: 230))
        view.backgroundColor = UIColor.whiteColor()
        if !ProgressHUD.isVisible() {
            ProgressHUD.showWithStatus("正在加载中")
        }
    }
}

//MARK:extension
extension HESuperMarketViewController :UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return superMarketData?.data?.categories?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let category = superMarketData?.getCategories()[indexPath.row]
        let cell = HECategoryCell.getCellFor(tableView: tableView)
        cell.categorie = category
        return cell
    }
}
extension HESuperMarketViewController :UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //1, 商品滚到指定section处
        productsVC.selectSection(indexPath.row)
        
        //2, 滚动到中间位置
     
        let contentViewHeight = CGFloat(tableView.numberOfRowsInSection(0)) * tableView.rowHeight
        let selectedCellCenterY = tableView.cellForRowAtIndexPath(indexPath)!.center.y
        var offsetY = selectedCellCenterY - tableView.center.y
        if offsetY < 0 {
           offsetY = 0
        }else if(selectedCellCenterY > contentViewHeight - tableView.height/2){ //后半部分
           offsetY = contentViewHeight - tableView.height + tableView.contentInset.bottom;
        }
        tableView.setContentOffset(CGPointMake(0, offsetY), animated: true)
    }
}

//下拉刷新的代理
extension HESuperMarketViewController :HEProductViewControllerDelegate{
    func startRefresh(refreshHeader: HERefreshHeader?) {
        weak var tmpSelf = self
        HESuperMarket.loadData { (data, error) -> Void in
            if data != nil{
                tmpSelf!.superMarketData = data
            }
            if refreshHeader != nil{
                 refreshHeader!.endRefreshing()
            }
          tmpSelf?.categoryTableView.selectRowAtIndexPath( NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: .Top)
            ProgressHUD.dismiss()
        }
    }
    
    func willDisplaySection(section:Int){
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section, inSection: 0), animated: true, scrollPosition: .Middle)
    }
    
    func didEndDisplaySection(section: Int) {
        categoryTableView.selectRowAtIndexPath(NSIndexPath(forRow: section+1, inSection: 0), animated: true, scrollPosition: .Middle)
    }
}




