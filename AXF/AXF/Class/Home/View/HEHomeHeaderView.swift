//
//  HEHomeHeaderView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/4.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHomeHeaderView: UIView {
    var pageScrollView:HEPageScrollView!
    var hotView:HEHotView!
    var data: HeadData!{
        didSet{
            if data == nil{
                print("HEHomeHeaderView,data是空")
                return
            }
            pageScrollView.focus = data.focus
            hotView.icons = data.icons
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pageScrollView = HEPageScrollView()
        addSubview(pageScrollView)
        
        hotView = HEHotView()
        addSubview(hotView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.31)
        hotView.frame.origin = CGPointMake(0, CGRectGetMaxY(pageScrollView.frame))
        let h = CGRectGetMaxY(hotView.frame)
        
        frame = CGRectMake(0, -h, ScreenWidth, h)
        NSNotificationCenter.defaultCenter().postNotificationName(HEHomeHeaderViewHeightChanged, object: nil, userInfo: ["height":"\(h)"])
    }
}
