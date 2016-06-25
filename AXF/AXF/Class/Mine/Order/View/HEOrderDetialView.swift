//
//  HEOrderDetialVIew.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/12.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  订单详情

import UIKit

class HEOrderDetialView: UIView {
    
    let orderNumberLabel = UILabel()
    let consigneeLabel = UILabel()
    let orderBuyTimeLabel = UILabel()
    let deliverTimeLabel = UILabel()
    let deliverWayLabel = UILabel()
    let payWayLabel = UILabel()
    let remarksLabel = UILabel()
    
    var order: Order? {
        didSet {
            orderNumberLabel.text = "订  单  号    " + order!.order_no!
            consigneeLabel.text = "收  货  码    " + order!.checknum!
            orderBuyTimeLabel.text = "下单时间    " + order!.create_time!
            deliverTimeLabel.text = "配送时间    " + order!.accept_time!
            deliverWayLabel.text = "配送方式    送货上门"
            payWayLabel.text =  "支付方式    在线支付"
            if order?.postscript != nil {
                remarksLabel.text = "备注信息    " + order!.postscript!
            } else {
                remarksLabel.text = "备注信息"
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        initLabel(orderNumberLabel)
        initLabel(consigneeLabel)
        initLabel(orderBuyTimeLabel)
        initLabel(deliverTimeLabel)
        initLabel(deliverWayLabel)
        initLabel(payWayLabel)
        initLabel(remarksLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 初始化label*/
    private func initLabel(label:UILabel){
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = HETextBlackColor
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftMargin: CGFloat = 10
        let labelWidth: CGFloat = width - 2 * leftMargin
        let labelHeight: CGFloat = 25
        
        orderNumberLabel.frame  = CGRectMake(leftMargin, 5, labelWidth, labelHeight)
        consigneeLabel.frame    = CGRectMake(leftMargin, CGRectGetMaxY(orderNumberLabel.frame), labelWidth, labelHeight)
        orderBuyTimeLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(consigneeLabel.frame), labelWidth, labelHeight)
        deliverTimeLabel.frame  = CGRectMake(leftMargin, CGRectGetMaxY(orderBuyTimeLabel.frame), labelWidth, labelHeight)
        deliverWayLabel.frame   = CGRectMake(leftMargin, CGRectGetMaxY(deliverTimeLabel.frame), labelWidth, labelHeight)
        payWayLabel.frame       = CGRectMake(leftMargin, CGRectGetMaxY(deliverWayLabel.frame), labelWidth, labelHeight)
        remarksLabel.frame      = CGRectMake(leftMargin, CGRectGetMaxY(payWayLabel.frame), labelWidth, labelHeight)
        
    }
}
