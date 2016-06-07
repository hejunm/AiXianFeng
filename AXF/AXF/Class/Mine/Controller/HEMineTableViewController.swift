//
//  HEMineTableViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/6.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMineTableViewController: HECommonTableViewController {
    
    private var tableHeaderView:HEMineTableHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        buildGroup()
        buildTableHeader()
    }
    
    private func buildTableHeader(){
        tableHeaderView = HEMineTableHeaderView()
        tableHeaderView.frame = CGRectMake(0, 0, view.width, 70)
        tableView?.tableHeaderView = tableHeaderView
    }
    
    private func buildGroup(){
        
        let group1 = HECommenGroup()
        let address = HECommonItemArrow()
        address.iconName = "v2_my_address_icon"
        address.title = "我的收货地址"
        group1.items.append(address)
        
        let store = HECommonItemArrow()
        store.iconName = "icon_mystore"
        store.title = "我的店铺"
        group1.items.append(store)
        
        //-------------------
        
        let group2 = HECommenGroup()
        let share = HECommonItemArrow()
        share.iconName = "v2_my_share_icon"
        share.title = "把乐先锋分享给好友"
        group2.items.append(share)
        
        //------------------------
        
        let group3 = HECommenGroup()
        let help = HECommonItemArrow()
        help.iconName = "online_service"
        help.title = "客服帮助"
        group3.items.append(help)
        
        let feedback = HECommonItemArrow()
        feedback.iconName = "v2_my_feedback_icon"
        feedback.title = "意见反馈"
        group3.items.append(feedback)
        
        groups = [group1,group2,group3]
    }
}

class HEMineTableHeaderView:UIView{
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
        addSubview(orderBtn)
        
        couponBtn = HEUpImageViewDownTitleLabelButton()
        couponBtn.setTitle("优惠券", forState: .Normal)
        couponBtn.setImage(UIImage(named: "v2_my_coupon_icon"), forState: .Normal)
        couponBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        couponBtn.setTitleColor(UIColor.colorWithCustom(80, g: 80, b: 80), forState: .Normal)
        addSubview(couponBtn)
        
        messageBtn = HEUpImageViewDownTitleLabelButton()
        messageBtn.setTitle("我的消息", forState: .Normal)
        messageBtn.setImage(UIImage(named: "v2_my_message_icon"), forState: .Normal)
        messageBtn.titleLabel?.font = UIFont.systemFontOfSize(13)
        messageBtn.setTitleColor(UIColor.colorWithCustom(80, g: 80, b: 80), forState: .Normal)
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
}


