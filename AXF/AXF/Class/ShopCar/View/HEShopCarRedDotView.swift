//
//  HEShopCarRedDotView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEShopCarRedDotView: HEBadgeView {
    private  var number = 0
    private  var isAnimation = false //当前正在动画
    
    private static let instance = HEShopCarRedDotView()

    /** 生成单例*/
    class var shareShopCarRedDotView:HEShopCarRedDotView {
        return instance
    }
    
    /**添加商品数量*/
    func addProductNum(animation:Bool){
        number += 1
        self.setBadgeValue(number)
        if !animation{ return}
        startAni()
    }
    
    /**减少商品数量*/
    func reduceProductNum(animation:Bool){
        if number>0{
            number -= 1
            self.setBadgeValue(number)
            if !animation{ return}
            startAni()
        }
    }
    
    private func startAni(){
        if isAnimation{  return }
        isAnimation = true
        let ShopCarRedDotAnimationDuration: NSTimeInterval = 0.2
        UIView.animateWithDuration(ShopCarRedDotAnimationDuration, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1.5, 1.5)
            }, completion: { (completion) -> Void in
                UIView.animateWithDuration(ShopCarRedDotAnimationDuration, animations: { () -> Void in
                    self.transform = CGAffineTransformIdentity
                    }, completion: {(completion) -> Void in
                        self.isAnimation = false
                })
        })
    }
}
