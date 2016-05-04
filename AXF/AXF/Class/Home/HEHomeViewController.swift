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
    var headerView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildCollectionView()
        
        buildHeaderTableView()
        
        
    }
    
    private func buildHeaderTableView(){
        headerView = UIView(frame: CGRectMake(0, 0, ScreenWidth, -100))
        headerView.backgroundColor = UIColor.yellowColor()
        collectionView.addSubview(headerView)
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
    }
    
    private func buildCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = HEHomeCollectionViewCellMargin
        layout.minimumLineSpacing = HEHomeCollectionViewCellMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: HEHomeCollectionViewCellMargin, bottom: 0, right: HEHomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSizeMake(0, HEHomeCollectionViewCellMargin)
        
        collectionView = HEHomeCollectionView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-64), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = HEGlobalBackgroundColor
        
        let refreshHeadView = HERefreshHeader(refreshingTarget: self, refreshingAction: "headRefresh")
        refreshHeadView.gifView?.frame = CGRectMake(0, 30, 100, 100)
        collectionView.mj_header = refreshHeadView

        self.view .addSubview(collectionView)
    }
}

//MARK: 事件处理
func headRefresh(){
    
}

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

