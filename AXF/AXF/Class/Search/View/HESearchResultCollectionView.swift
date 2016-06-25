//
//  HESearchResultCollectionView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/19.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESearchResultCollectionView: UICollectionView {
    
    var headerView:HENoSearchResultView!
    
    init(frame:CGRect){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = HEHomeCollectionViewCellMargin
        layout.minimumLineSpacing = HEHomeCollectionViewCellMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: HEHomeCollectionViewCellMargin, bottom: 0, right: HEHomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HEHomeCollectionViewCellMargin)
        super.init(frame: frame, collectionViewLayout: layout)
        
        headerView = HENoSearchResultView(frame: CGRectMake(0,-80,ScreenWidth,80))
        addSubview(headerView)
        contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 30, right: 0)
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
