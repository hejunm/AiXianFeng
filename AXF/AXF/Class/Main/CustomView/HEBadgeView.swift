//
//  HEBadgeView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  用于显示 Badge

import UIKit

class HEBadgeView: UIButton {
    
    private var defaultWidth:CGFloat = 0
    //返回不同的实例
    class func getBadgeView() ->HEBadgeView{
        return HEBadgeView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //reddot
        var reddotImage = UIImage(named: "reddot")!
        reddotImage = reddotImage.stretchableImageWithLeftCapWidth(Int(reddotImage.size.width*0.5), topCapHeight: Int(reddotImage.size.height*0.5))
        setBackgroundImage(reddotImage, forState: .Normal)
        
        height = reddotImage.size.height
        defaultWidth = currentBackgroundImage!.size.width + 3
        titleLabel?.font = UIFont.systemFontOfSize(10)
        setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    convenience init() {
        self.init(frame:CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setBadgeValue(value:Int){
        if value == 0 {
            setTitle(nil, forState: .Normal)
            hidden = true
            return
        }
        hidden = false
        setTitle("\(value)", forState: .Normal)
        guard let title:NSString = titleLabel?.text else{
            return
        }
        let  badgeValueWidth =  title.sizeWithAttributes([NSFontAttributeName: titleLabel!.font]).width
        if badgeValueWidth > defaultWidth{
            width = badgeValueWidth + 10
        }else{
            width = defaultWidth
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
