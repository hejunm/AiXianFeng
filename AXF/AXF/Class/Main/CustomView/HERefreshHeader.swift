//
//  HERefreshHeader.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/3.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HERefreshHeader:MJRefreshGifHeader  {
    override func prepare() {
        super.prepare()
        stateLabel?.hidden = false
        lastUpdatedTimeLabel?.hidden = true
        
        setImages([UIImage(named: "v2_pullRefresh1")!], forState: MJRefreshState.Idle)
        setImages([UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshState.Pulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshState.Refreshing)
        
        setTitle("下拉刷新", forState: .Idle)
        setTitle("松手开始刷新", forState: .Pulling)
        setTitle("正在刷新", forState: .Refreshing)
    }
}
