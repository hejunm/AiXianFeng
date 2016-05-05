//
//  HEHomeCollectionView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/2.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  将头部的滚动试图，下拉刷新都放在这里

import UIKit

class HEHomeCollectionView: UICollectionView {
    
    var headerView:HEHomeHeaderView!  //循环滚动视图和icon试图
    var refreshHeadView:HERefreshHeader!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout?) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = HEHomeCollectionViewCellMargin
        layout.minimumLineSpacing = HEHomeCollectionViewCellMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: HEHomeCollectionViewCellMargin, bottom: 0, right: HEHomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HEHomeCollectionViewCellMargin)
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        buildHeaderView()
        buildRefreshView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setHeaderViewHeight:", name: HEHomeHeaderViewHeightChanged, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHeaderView(){
        headerView = HEHomeHeaderView()
        addSubview(headerView)
    }
    
    private func buildRefreshView(){
        refreshHeadView = HERefreshHeader(refreshingTarget: self, refreshingAction: "headRefresh")
        header = refreshHeadView
    }
    
    //MARK: --事件
    func setHeaderViewHeight(noti: NSNotification){
        
        if let h = noti.userInfo?["height"] as? NSString{
            let hFloat = CGFloat(h.floatValue)
            
            headerView.frame =  CGRectMake(0, -hFloat, ScreenWidth, hFloat)
            contentInset = UIEdgeInsets(top: headerView.height, left: 0, bottom: 0, right: 0)
            setContentOffset(CGPoint(x: 0, y: -(contentInset.top)), animated: false)
            
            refreshHeadView.ignoredScrollViewContentInsetTop = headerView.height
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
