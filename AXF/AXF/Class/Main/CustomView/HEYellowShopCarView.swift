//
//  HEYellowShopCarView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEYellowShopCarView: UIButton {
    
    //初期设计存在问题，不应该使用单例。购物车工具类和显示购物车中商品数量的redDot耦合性太高，应该使用通知。
    let redDot = HEShopCarRedDotView.shareShopCarRedDotView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundImage(UIImage(named: "v2_shop_empty"), forState: .Normal)
        setBackgroundImage(UIImage(named: "v2_shop_empty"), forState: .Highlighted)
        imageView?.contentMode = .ScaleAspectFit
        redDot.setBadgeValue(HEShopCarTools.shareShopCarTools.getShopCarBadgeValue())
        addSubview(redDot)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        redDot.frame = CGRectMake(width-20, 0, 20, 20)
    }
}
