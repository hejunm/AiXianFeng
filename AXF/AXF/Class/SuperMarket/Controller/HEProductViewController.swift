//
//  HEProductViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit


protocol HEProductViewControllerDelegate :NSObjectProtocol{
   
    /**刷新header的代理*/
    func startRefresh(refreshHeader:HERefreshHeader?)
    func willDisplaySection(section:Int)
    func didEndDisplaySection(section:Int)
}

class HEProductViewController: HEAnimationController {
    
    //MARK: property
    var produceTableView:UITableView!
    var refreshHeader:HERefreshHeader!
    var delegate:HEProductViewControllerDelegate!
    var superMarketData:HESuperMarket?{     //数据
        didSet{
            if superMarketData == nil{
                return
            }
            produceTableView.reloadData()
        }
    }
    var isScrollDown:Bool = false  //是否在向下滚动
    var lastScrollY:CGFloat = 0    //上次偏移量
    var isScrollByDrag:Bool = false //滚动是否是通过拖动导致的
   
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = UIView(frame: CGRectMake(ScreenWidth*0.25, 0, ScreenWidth*0.75, ScreenHeight-NavigationH))
        buildProduceTableView()
        buildRefreachHeader()
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        super.didMoveToParentViewController(parent)
        produceTableView.frame = view.bounds
        produceTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: HETabBarH, right: 0)
        produceTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: HETabBarH, right: 0)
        refreshHeader.beginRefreshing()
    }
    
    //MARK: private func
    private func buildProduceTableView(){
        produceTableView = UITableView(frame: CGRectZero, style: .Plain)
        produceTableView.rowHeight = 85
        produceTableView.sectionHeaderHeight = 25
        produceTableView.delegate = self
        produceTableView.dataSource = self
        produceTableView.registerClass(HESuperMarketHeaderView.self, forHeaderFooterViewReuseIdentifier: HESuperMarketHeaderView.Id)
        view.addSubview(produceTableView)
    }
    
    private func buildRefreachHeader(){
        refreshHeader = HERefreshHeader(refreshingTarget: self, refreshingAction: "loadDataAction")
        produceTableView.header = refreshHeader
    }
    
    //下拉刷新
    func loadDataAction(){
        if delegate != nil{
            delegate.startRefresh(refreshHeader)
        }
    }
    /**根据category 指定选中的section */
    func selectSection(section:Int){
        isScrollByDrag = false
        produceTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: section), animated: true, scrollPosition: .Top)
    }
}

extension HEProductViewController:UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return superMarketData?.getCategories().count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return superMarketData?.getGoodsArrayForCategoryAt(index: section).count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = HEProductCell.getCellFor(tableView: tableView)
        let goods = superMarketData?.getGoodsArrayForCategoryAt(index: indexPath.section)[indexPath.row]
        cell.goods = goods
        weak var tmpSelf = self
        cell.addGoodsToShopCerAnim({ (imageView) -> () in //添加商品时的动画
            tmpSelf?.addProductsAnimation(imageView)
        })
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HESuperMarketHeaderView.getHeaderViewFor(tableView: tableView)
        let category = superMarketData?.getCategories()[section]
        headerView.setTitle(category?.name)
        return headerView
    }
}

extension HEProductViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if delegate != nil && isScrollDown && isScrollByDrag{ //向下时，显示section
            delegate.willDisplaySection(section)
            print("willDisplaySection")
        }
    }
    func tableView(tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if delegate != nil && !isScrollDown && isScrollByDrag{     //向上时，上一个消失，切换到下一个 section+1
            delegate.didEndDisplaySection(section)
            print("didEndDisplayingHeaderView")
        }
    }
    
    // --UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        cleanAllAnimationLayers()
        isScrollDown =  lastScrollY > scrollView.contentOffset.y
        lastScrollY = scrollView.contentOffset.y
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        print("scrollViewDidEndScrollingAnimation")
        //isScrollByDrag = true
    }
}