//
//  HEHotView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/5.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHotView: UIView {
    private let iconW = (ScreenWidth-HEHotViewMargin*2)*0.25
    private let iconH:CGFloat = 80
    
    var icons: [Activitie]!{
        didSet{
            if icons == nil{
                print("icons 是空")
                return
            }
            buildSubViews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        width = ScreenWidth
        self.backgroundColor = UIColor.whiteColor()
    }
    
    private func buildSubViews(){
        for subView in subviews{
            subView.removeFromSuperview()
        }
        
        for i in 0..<icons.count{
            let iconX = CGFloat(i%4)*iconW + HEHotViewMargin
            let iconY = CGFloat(i/4)*iconH
            let iconView =  HEIconTitleView(frame:CGRectMake(iconX, iconY, iconW, iconH))
            iconView.activity = icons[i]
            addSubview(iconView)
        }
        
        var h:CGFloat = 0
        if icons != nil {
            if icons.count % 4 != 0 {
                h = iconH * CGFloat(icons.count/4+1)
            }else{
                h = iconH * CGFloat(icons.count/4)
            }
        }
        height = h
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
