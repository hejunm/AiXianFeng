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
        pageScrollView = HEPageScrollView(frame: CGRectMake(0, 0, ScreenWidth, ScreenWidth*0.31))
        addSubview(pageScrollView)
        
        //这里的高度是随意指定的， 在后面需要修改
        hotView = HEHotView(frame: CGRectMake(0, pageScrollView.height, ScreenWidth, 0))
        addSubview(hotView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
