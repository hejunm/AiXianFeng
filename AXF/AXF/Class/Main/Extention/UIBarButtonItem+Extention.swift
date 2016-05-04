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
    
    class func customItemWith(title:String,normalTitleColor:UIColor,image:UIImage,highlightedImage:UIImage?,type:ItemButtonType,target:AnyObject?,action:Selector)->UIBarButtonItem{
        
        let btn:UIButton!
        if type == .Left{
            btn = HEButtonForLeftBarButtonItem()
        }else{
            btn = HEButtonForRightBarButtonItem()
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
}
