//
//  HERefreshHeader.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/3.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HERefreshHeader:MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        stateLabel?.hidden = false
        lastUpdatedTimeLabel?.hidden = true
        setImages([UIImage(named: "v2_pullRefresh1")!], forState: MJRefreshStateIdle)
        setImages([UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshStatePulling)
        setImages([UIImage(named: "v2_pullRefresh1")!, UIImage(named: "v2_pullRefresh2")!], forState: MJRefreshStateRefreshing)
        
        setTitle("下拉刷新", forState: MJRefreshStateIdle)
        setTitle("松手开始刷新", forState: MJRefreshStatePulling)
        setTitle("正在刷新", forState: MJRefreshStateRefreshing)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setHeaderViewHeight:", name: HEHomeHeaderViewHeightChanged, object: nil) //collection中的header高度确定后,设置
    }
    
    //MARK: 事件
    /**
        HEHotView的高度根据请求到的数据量 是可以改变的， 所以contentInset.top 在每次刷新数据后都可能改变。
        如果没有下面的语句, header 显示的位置就会不正确。
    */
    func setHeaderViewHeight(noti:NSNotification){
        if let h = noti.userInfo?["height"] as? NSString{
            let top = CGFloat(h.floatValue) + height
            self.scrollView?.mj_insetT = top
            ignoredScrollViewContentInsetTop = CGFloat(h.floatValue)
            self.mj_y = -self.mj_h - self.ignoredScrollViewContentInsetTop;
        }
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
