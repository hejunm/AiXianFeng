//
//  HEHeaderReserveView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  可预订

import UIKit

class HEHeaderReserveView: UIView {
    private let signTimeTitleLabel = UILabel() //"收货时间"
    private let signTimeLabel = UILabel()      //"闪电送，及时达"
    private let canReserveLabel = UIButton()    //"可预订"
    private let arrowImageView = UIImageView(image:UIImage(named:"icon_go"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         backgroundColor = UIColor.whiteColor()
        
        signTimeTitleLabel.text = "收货时间"
        signTimeTitleLabel.textColor = UIColor.blackColor()
        signTimeTitleLabel.font = UIFont.systemFontOfSize(15)
        signTimeTitleLabel.sizeToFit()
        addSubview(signTimeTitleLabel)
        
        signTimeLabel.text = "闪电送,及时达"
        signTimeLabel.textColor = UIColor.redColor()
        signTimeLabel.font = UIFont.systemFontOfSize(15)
        signTimeLabel.sizeToFit()
        addSubview(signTimeLabel)
        
        canReserveLabel.setTitle("可预订", forState: .Normal)
        canReserveLabel.setTitleColor(UIColor.redColor(), forState: .Normal)
        canReserveLabel.titleLabel?.font = UIFont.systemFontOfSize(15)
        addSubview(canReserveLabel)
        
        arrowImageView.contentMode = .Center
        addSubview(arrowImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        signTimeTitleLabel.frame = CGRectMake(15, 0, signTimeTitleLabel.width, height)
        signTimeLabel.frame = CGRectMake(CGRectGetMaxX(signTimeTitleLabel.frame)+5, 0, signTimeLabel.width, height)
        canReserveLabel.frame = CGRectMake(width-80, 0, 60, height)
        arrowImageView.frame = CGRectMake(CGRectGetMaxX(canReserveLabel.frame), 0, 10, height)
    }
}
