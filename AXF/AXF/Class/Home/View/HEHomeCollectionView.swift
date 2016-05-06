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
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout?) {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = HEHomeCollectionViewCellMargin
        layout.minimumLineSpacing = HEHomeCollectionViewCellMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: HEHomeCollectionViewCellMargin, bottom: 0, right: HEHomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HEHomeCollectionViewCellMargin)
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        buildHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildHeaderView(){
        headerView = HEHomeHeaderView()
        addSubview(headerView)
    }
}
