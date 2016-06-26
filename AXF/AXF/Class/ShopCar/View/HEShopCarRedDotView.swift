//
//  HEShopCarRedDotView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEShopCarRedDotView: HEBadgeView {
    
    private  var isAnimation = false //当前正在动画
    /** 并非单例*/
    class var shareShopCarRedDotView:HEShopCarRedDotView {
        let instance = HEShopCarRedDotView()
        NSNotificationCenter.defaultCenter().addObserver(instance, selector: #selector(HEShopCarRedDotView.changeProductNum(_:)), name: HENotiShopCarProduceNumChanged, object: nil)
        instance.userInteractionEnabled = false
        return instance
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /**修改商品数量*/
    func changeProductNum(noti:NSNotification){
        self.setBadgeValue(HEShopCarTools.shareShopCarTools.getShopCarBadgeValue())
        //if !animation{ return}
        startAni()
    }
    
    private func startAni(){
        if isAnimation{ return }
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
