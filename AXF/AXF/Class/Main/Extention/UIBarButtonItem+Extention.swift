//
//  UIBarButtonItem+Extention.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

enum ItemButtonType:Int{
    case Left = 0
    case Right = 1
}


extension UIBarButtonItem{
    /**
     自定义UIBarButtonItem（上下结构）
     */
    class func customItemWith(title:String,normalTitleColor:UIColor,image:UIImage,highlightedImage:UIImage?,type:ItemButtonType,target:AnyObject?,action:Selector)->UIBarButtonItem{
        
        let btn:UIButton!
        var offsetX:CGFloat = 0
        if type == .Left{
            btn = HEUpImageViewDownTitleLabelButton()
            offsetX = -15
        }else{
            btn = HEUpImageViewDownTitleLabelButton()
            offsetX = 15
        }
        
        if btn.imageView != nil{
            btn.imageView!.x = btn.imageView!.x + offsetX
        }
        if btn.titleLabel != nil{
            btn.titleLabel!.x = btn.titleLabel!.x + offsetX
        }
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(normalTitleColor, forState: .Normal)
        btn.setImage(image, forState: .Normal)
        btn.setImage(highlightedImage, forState: .Highlighted)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        btn.frame = CGRectMake(0, 0, 60, 44)
        
        return UIBarButtonItem(customView: btn)
    }
    
    /**
     导航控制器中的返回按钮
     
     - parameter target: target
     - parameter action: action
     
     - returns: instance of UIBarButtonItem
     */
    class func backBarButtonItem(target: AnyObject?, action: Selector)->UIBarButtonItem{
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.setImage(UIImage(named: "v2_goback"), forState: .Normal)
        backBtn.titleLabel?.hidden = true
        backBtn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        backBtn.frame = CGRectMake(0, 0, btnW, 40)
        return UIBarButtonItem(customView: backBtn)
    }
    
    class func barButton(title: String, titleColor: UIColor, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton(frame: CGRectMake(0, 0, 60, 44))
        btn.setTitle(title, forState: .Normal)
        btn.setTitleColor(titleColor, forState: .Normal)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        if title.characters.count == 2 {
            btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -25)
        }
        return UIBarButtonItem(customView: btn)
    }
}
