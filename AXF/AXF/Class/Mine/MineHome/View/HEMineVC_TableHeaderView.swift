//
//  HEMineTableHeaderView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

protocol HEMineVC_TableHeaderViewDelegate {
    func headerViewBtnClick(type:HEMineVC_TableHeaderViewBtnType)
}

enum HEMineVC_TableHeaderViewBtnType {
    case Order
    case Coupon
    case Message
}
class HEMineVC_TableHeaderView:UIView{
    var delegate:HEMineVC_TableHeaderViewDelegate?
    var orderBtn:HEUpImageViewDownTitleLabelButton!  //我的订单
    var couponBtn:HEUpImageViewDownTitleLabelButton! //优惠券
    var messageBtn:HEUpImageViewDownTitleLabelButton!//我的消息
    let lineView1 = UIView()
    let lineView2 = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        orderBtn = HEUpImageViewDownTitleLabelButton()
        orderBtn.setTitle("我的订单", forState: .Normal)
        orderBtn.setImage(UIImage(named: "v2_my_order_icon"), forState: .Normal)
        orderBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        orderBtn.setTitleColor(UIColor.colorWithCustom(80, g: 80, b: 80), forState: .Normal)
        orderBtn.addTarget(self, action: #selector(HEMineVC_TableHeaderView.tableHeaderBtnClick(_:)), forControlEvents: .TouchUpInside)
        addSubview(orderBtn)
        
        couponBtn = HEUpImageViewDownTitleLabelButton()
        couponBtn.setTitle("优惠券", forState: .Normal)
        couponBtn.setImage(UIImage(named: "v2_my_coupon_icon"), forState: .Normal)
        couponBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        couponBtn.setTitleColor(UIColor.colorWithCustom(80, g: 80, b: 80), forState: .Normal)
        couponBtn.addTarget(self, action: #selector(HEMineVC_TableHeaderView.tableHeaderBtnClick(_:)), forControlEvents: .TouchUpInside)
        addSubview(couponBtn)
        
        messageBtn = HEUpImageViewDownTitleLabelButton()
        messageBtn.setTitle("我的消息", forState: .Normal)
        messageBtn.setImage(UIImage(named: "v2_my_message_icon"), forState: .Normal)
        messageBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        messageBtn.setTitleColor(UIColor.colorWithCustom(80, g: 80, b: 80), forState: .Normal)
        messageBtn.addTarget(self, action: #selector(HEMineVC_TableHeaderView.tableHeaderBtnClick(_:)), forControlEvents: .TouchUpInside)
        addSubview(messageBtn)
        
        lineView1.backgroundColor = UIColor.grayColor()
        lineView1.alpha = 0.3
        addSubview(lineView1)
        
        lineView2.backgroundColor = UIColor.grayColor()
        lineView2.alpha = 0.3
        addSubview(lineView2)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let eachBtnW = width/3
        let eachBtnH = height - 5
        orderBtn.frame = CGRectMake(0, 0, eachBtnW, eachBtnH)
        couponBtn.frame = CGRectMake(eachBtnW, 0, eachBtnW, eachBtnH)
        messageBtn.frame = CGRectMake(eachBtnW*2, 0, eachBtnW, eachBtnH)
        lineView1.frame = CGRectMake(eachBtnW-0.5, height*0.2, 1, height*0.6)
        lineView2.frame = CGRectMake(eachBtnW*2-0.5, height*0.2, 1, height*0.6)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableHeaderBtnClick(sender:UIButton){
        if delegate == nil{ return}
        switch sender {
        case orderBtn: //我的订单
            delegate?.headerViewBtnClick(.Order)
            break
        case couponBtn: //优惠券
            delegate?.headerViewBtnClick(.Coupon)
            break
        case messageBtn: //我的消息
            delegate?.headerViewBtnClick(.Message)
            break
        default:
            break
        }
    }
}
