//
//  GuideViewController:.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  新手指导

import UIKit

class GuideViewController: HEBaseViewController {
    
    
    private var collectionView:UICollectionView?
    private var pageControl = UIPageControl(frame: CGRectMake(0, ScreenHeight - 50, ScreenWidth, 20))
    private var images = ["guide_40_1", "guide_40_2", "guide_40_3", "guide_40_4"]
    private let cellId = "GuideCell"
    private var isHiddenNextButton = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        setupPageControll()
    }
    
    private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = ScreenBounds.size
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView = UICollectionView(frame: ScreenBounds, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false //去除弹簧效果
        collectionView?.registerClass(GuideCell.self, forCellWithReuseIdentifier:cellId)
        self.view.addSubview(collectionView!);
    }
    
    private func setupPageControll(){
        self.view .addSubview(pageControl)
        pageControl.numberOfPages = images.count
    }
}

extension GuideViewController :UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! GuideCell;
        cell.image = UIImage(named: images[indexPath.row])
        return cell;
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == ScreenWidth * (CGFloat)(images.count-1){
            let cell = collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: images.count-1, inSection: 0)) as! GuideCell
            cell.hiddenBtn(false)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
        if scrollView.contentOffset.x < ScreenWidth * (CGFloat)(images.count-1){
            let cell = collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: pageIndex, inSection: 0)) as! GuideCell
            cell.hiddenBtn(true)
        }
        pageControl.currentPage = pageIndex
    }
    
}
