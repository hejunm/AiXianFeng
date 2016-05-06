//
//  HEHomeViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHomeViewController: HESelectedAdressViewController {
    
    var collectionView:HEHomeCollectionView!
    var refreshHeadView:HERefreshHeader!    //下拉刷新
   
// MARK: --初始化
    override func viewDidLoad() {
        super.viewDidLoad()
        buildNotificaton()
        buildCollectionView()
        buildRefreshView()
        headRefresh()
    }

    private func buildCollectionView(){
        collectionView = HEHomeCollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-64), collectionViewLayout: nil)
        collectionView.backgroundColor = HEGlobalBackgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.view.addSubview(collectionView)
    }
    
    private func buildNotificaton(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fouceImageClick:",name:HEHomeViewControllerForceImageClick , object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "iconClick:",name:HEHomeViewControllerIconClick , object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setHeaderViewHeight:", name: HEHomeHeaderViewHeightChanged, object: nil) //collection中的header高度确定后,设置
    }
    
    private func buildRefreshView(){
        refreshHeadView = HERefreshHeader(refreshingTarget: self, refreshingAction: "headRefresh")
        collectionView.header = refreshHeadView
    }
    
    
    override func viewDidAppear(animated: Bool) { //开始自动轮播
        super.viewDidAppear(animated)
        collectionView.headerView.pageScrollView.startTimer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        collectionView.headerView.pageScrollView.endTimer() //结束自动轮播
    }
    
//MARK: --事件
    func headRefresh(){
        //1, 获取头部数据： 滚动，icon，活动
        weak var tempSelf = self
        HeadResources.loadData { (data, error) -> Void in
            if let headerData = data.data{
                if tempSelf!.refreshHeadView.isRefreshing() {
                    tempSelf!.refreshHeadView.endRefreshing()
                }
                
                tempSelf!.collectionView.headerView.data = headerData
            }
        }
    }
    
    func fouceImageClick(noti:NSNotification){
        print(noti)
    }
    
    func iconClick(noti:NSNotification){
        print(noti)
    }
    
    func setHeaderViewHeight(noti: NSNotification){
        if let h = noti.userInfo?["height"] as? NSString{
            let hFloat = CGFloat(h.floatValue)
            
            collectionView.headerView.frame =  CGRectMake(0, -hFloat, ScreenWidth, hFloat)
            collectionView.contentInset = UIEdgeInsets(top: collectionView.headerView.height, left: 0, bottom: 0, right: 0)
            collectionView.setContentOffset(CGPoint(x: 0, y: -(collectionView.contentInset.top)), animated: false)
            refreshHeadView.ignoredScrollViewContentInsetTop = hFloat
        }
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
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.blueColor()
        return cell
    }
    
    //MARK: --UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var itemSize = CGSizeZero
        if indexPath.section == 0 {
            itemSize = CGSizeMake(ScreenWidth - HEHomeCollectionViewCellMargin * 2, 140)
        } else if indexPath.section == 1 {
            itemSize = CGSizeMake((ScreenWidth - HEHomeCollectionViewCellMargin * 2) * 0.5 - HEHomeCollectionViewCellMargin/2, 250)
        }
        return itemSize
    }
}

