//
//  HEHomeViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHomeViewController: HESelectedAdressViewController{

// MARK: --参数
    var collectionView:HEHomeCollectionView!
    var refreshHeadView:HEDynamicYRefreshHeader!    //下拉刷新
    var activities: [Activitie]?            //活动
    var freshHot :FreshHot?                 //新鲜热卖
    var isAnimation = false                //当向上滚动scrollView时，可以有动画
    var lastContentOffsetY:CGFloat = 0
   
// MARK: --初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildNotificaton()
        buildCollectionView()
        buildRefreshView()
        refreshHeadView.beginRefreshing()
    }
    override func viewDidAppear(animated: Bool) { //开始自动轮播
        super.viewDidAppear(animated)
        collectionView.headerView.pageScrollView.startTimer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        collectionView.headerView.pageScrollView.endTimer() //结束自动轮播
    }
    
    private func buildCollectionView(){
        collectionView = HEHomeCollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-NavigationH), collectionViewLayout: nil)
        collectionView.backgroundColor = HEGlobalBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(HEHomeHorizontalCell.self, forCellWithReuseIdentifier: "HEHomeHorizontalCell")
        collectionView.registerClass(HEHomeVerticalCell.self, forCellWithReuseIdentifier: "HEHomeVerticalCell")
        collectionView.registerClass(HEHomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView")
        collectionView.registerClass(HEHomeCollectionFootView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView")
        self.view.addSubview(collectionView)
    }
    
    private func buildNotificaton(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fouceImageClick:",name:HEHomeViewControllerForceImageClick , object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iconClick:",name:HEHomeViewControllerIconClick , object: nil)
    }
    
    private func buildRefreshView(){
        refreshHeadView = HEDynamicYRefreshHeader(refreshingTarget: self, refreshingAction: "headRefresh")
        collectionView.header = refreshHeadView
    }
    //请求数据
    func headRefresh(){
        weak var tempSelf = self
        var isHeadResourcesFinished = false
        var isFreshHotFinished = false
        
        //1, 获取头部数据： 滚动，icon，活动
        HeadResources.loadData { (data, error) -> Void in
            if let headerData = data.data{
                tempSelf!.collectionView.headerView.data = headerData
                tempSelf!.activities = headerData.activities
            }
            
            isHeadResourcesFinished = true
            if tempSelf!.refreshHeadView.isRefreshing() && isHeadResourcesFinished && isFreshHotFinished{
                tempSelf!.refreshHeadView.endRefreshing()
                tempSelf!.collectionView.reloadData()
            }
        }
        //2, 获取新鲜热卖数据
        FreshHot.loadData { (data, error) -> Void in
            if let freshHot = data{
                tempSelf!.freshHot = freshHot
            }
            
            isFreshHotFinished = true
            if tempSelf!.refreshHeadView.isRefreshing() && isHeadResourcesFinished && isFreshHotFinished{
                tempSelf!.refreshHeadView.endRefreshing()
                tempSelf!.collectionView.reloadData()
            }
        }
    }
    
    //跳到浏览器
    func pushToWebWithTitlt(title:String?,url:String?){
        let WebViewVC = HEWebViewController(title:title, url: url)
        navigationController?.pushViewController(WebViewVC, animated: true)
    }
    

//MARK: action
    
    func fouceImageClick(noti:NSNotification){
        if let activity = noti.userInfo?["focus"] as? Activitie{
            let webViewVC = HEWebViewController(title: activity.name, url: activity.customURL)
            navigationController?.pushViewController(webViewVC, animated: true)
        }
    }
    
    func iconClick(noti:NSNotification){
        if let activity = noti.userInfo?["icon"] as? Activitie{
            let webViewVC = HEWebViewController(title: activity.name, url: activity.customURL)
            navigationController?.pushViewController(webViewVC, animated: true)
        }
    }
    
    func loadMoreGoods(){
        let tabBarVC = UIApplication.sharedApplication().keyWindow?.rootViewController as! HEMainTabBarController
        tabBarVC.switchVC(.SuperMarket)
    }
    
//MARK: --销毁
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

//MARK:  --代理
extension HEHomeViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    //MARK:--UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        if ((activities?.count) != nil && freshHot != nil) {
            return 2
        }else{
            return 0
        }
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return activities?.count ?? 0
        }else{
            return freshHot?.data?.count ?? 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HEHomeHorizontalCell", forIndexPath: indexPath) as! HEHomeHorizontalCell
            cell.activity = activities?[indexPath.item]
            return cell
        }else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HEHomeVerticalCell", forIndexPath: indexPath) as! HEHomeVerticalCell
            cell.goods = freshHot?.data?[indexPath.item]
            
            weak var tmpSelf = self
            cell.addGoodsToShopCerAnim({ (imageView) -> () in //添加商品时的动画
                tmpSelf?.addProductsAnimation(imageView)
            })
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 1 && kind == UICollectionElementKindSectionHeader{
           return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headerView", forIndexPath: indexPath) as! HEHomeCollectionHeaderView
        }
        
        let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footerView", forIndexPath: indexPath) as! HEHomeCollectionFootView
        if indexPath.section == 1 && kind == UICollectionElementKindSectionFooter{
            footerView.showLable()
            let tap = UITapGestureRecognizer(target: self, action: "loadMoreGoods")
            footerView.addGestureRecognizer(tap)
        }else{
            footerView.hideLabel()
        }
        return footerView
    }
    
    //MARK: --UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            let activity = activities?[indexPath.item]
            let webViewVC = HEWebViewController(title: activity?.name, url: activity?.customURL)
            navigationController?.pushViewController(webViewVC, animated: true)
        }else{
             //MARK: TODO
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var itemSize = CGSizeZero
        if indexPath.section == 0 {
            itemSize = CGSizeMake(ScreenWidth - HEHomeCollectionViewCellMargin * 2, 130)
        } else if indexPath.section == 1 {
            itemSize = CGSizeMake((ScreenWidth - HEHomeCollectionViewCellMargin * 2) * 0.5 - HEHomeCollectionViewCellMargin/2, 250)
        }
        return itemSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(ScreenWidth, HEHomeCollectionViewCellMargin)
        } else if section == 1 {
            return CGSizeMake(ScreenWidth, HEHomeCollectionViewCellMargin * 3)
        }
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeMake(ScreenWidth, HEHomeCollectionViewCellMargin)
        } else if section == 1 {
            return CGSizeMake(ScreenWidth, HEHomeCollectionViewCellMargin * 6)
        }
        return CGSizeZero
    }
    
    //添加动画
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if isAnimation && indexPath.section != 0{
            cell.transform = CGAffineTransformMakeTranslation(0, 80)
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                cell.transform = CGAffineTransformIdentity
            })
        }
    }
    func collectionView(collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, atIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1{
            view.transform = CGAffineTransformMakeTranslation(0, 60)
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                view.transform = CGAffineTransformIdentity
            })
        }
    }
    
    // --UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        cleanAllAnimationLayers()
        isAnimation = lastContentOffsetY < scrollView.contentOffset.y
        lastContentOffsetY = scrollView.contentOffset.y
    }
}

