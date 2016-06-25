//
//  HEMineStoreVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  我的商铺

import UIKit

class HEMineStoreVC: HEBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的店铺"
        buildEmptyView()
    }
    
    private func buildEmptyView(){
        let emptyView = UIView(frame: view.bounds)
        emptyView.backgroundColor = HEGlobalBackgroundColor
        
        let normalImageView = UIImageView(image: UIImage(named: "v2_store_empty"))
        normalImageView.center = view.center
        normalImageView.center.y -= 150
        emptyView.addSubview(normalImageView)
        
        let normalLabel = UILabel()
        normalLabel.text = "还没有收藏的店铺呦~"
        normalLabel.textAlignment = NSTextAlignment.Center
        normalLabel.frame = CGRectMake(0, CGRectGetMaxY(normalImageView.frame) + 10, ScreenWidth, 50)
        emptyView.addSubview(normalLabel)
        view.addSubview(emptyView)
    }
}
