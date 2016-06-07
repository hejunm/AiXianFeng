//
//  HEEmptyGoodsView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEEmptyGoodsView : UIView{
    lazy var imageView:UIImageView! = {
        let imageView = UIImageView(image: UIImage(named: "v2_shop_empty"))
        imageView.contentMode = .Center
        return imageView
    }()
    
    lazy var infoLabel:UILabel! = {
        let infoLabel = UILabel()
        infoLabel.textAlignment = .Center
        infoLabel.font = UIFont.systemFontOfSize(16)
        infoLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        infoLabel.text = "亲,购物车空空的耶~赶紧挑好吃的吧"
        return infoLabel
    }()
    
    lazy var button:UIButton! = { //去逛逛
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "btn.png"), forState: .Normal)
        button.setTitle("去逛逛", forState: .Normal)
        button.setTitleColor(UIColor.colorWithCustom(100, g: 100, b: 100), forState: .Normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(infoLabel)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.x = (width - imageView.width)*0.5
        imageView.y = height*0.1
        infoLabel.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + 30, width, 50)
        button.frame =  CGRectMake((width - 150) * 0.5, CGRectGetMaxY(infoLabel.frame) + 50, 150, 30)
    }
    
    func addTarget(target: AnyObject?, action: Selector) {
        button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
    }
}

