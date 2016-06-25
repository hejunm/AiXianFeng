//
//  HEChoicePayWayViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/2.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  选择支付方式

import UIKit

class HEChoicePayWayViewController: HECommonTableViewController {

    private var footView:HEShopCarFootView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "结算付款"
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        buildGroup()
        buildFootView()
    }
    
    private func buildGroup(){
        //优惠券
        let couponGroup = HECommenGroup()
        let coupon = HECommonItemArrow()
        coupon.iconName = "v2_submit_Icon"
        coupon.title = "一张优惠券"
        coupon.subTitle = "查看"
        coupon.titleColor = UIColor.redColor()
        couponGroup.items.append(coupon)
        
        //支付方式
        let payWayGroup = HECommonCheckBoxGroup()
        let payWayGroupNameItem = HECommonItemOnlyLeftLabel()
        payWayGroupNameItem.title = "选择支付方式"
        payWayGroup.items.append(payWayGroupNameItem)

        
        let weinXinPay = HECommonItemSwitch(group:payWayGroup)
        weinXinPay.iconName = "v2_weixin"
        weinXinPay.title = "微信支付"
        weinXinPay.isSelected = false
        payWayGroup.items.append(weinXinPay)
       
       
        let qqWallet = HECommonItemSwitch(group:payWayGroup)
        qqWallet.iconName = "icon_qq"
        qqWallet.title = "QQ钱包"
        qqWallet.isSelected = false
        payWayGroup.items.append(qqWallet)
        
        
        let zhiFuBao = HECommonItemSwitch(group:payWayGroup)
        zhiFuBao.iconName = "zhifubaoA"
        zhiFuBao.title = "支付宝"
        zhiFuBao.isSelected = false
        payWayGroup.items.append(zhiFuBao)
        
        
        let COD = HECommonItemSwitch(group:payWayGroup)
        COD.iconName = "v2_dao"
        COD.title = "货到付款"
        COD.isSelected = true
        payWayGroup.items.append(COD)
        
        //精选商品
        let produceGroup = HECommenGroup()
        
        let produceGroupNameItem = HECommonItemOnlyLeftLabel()
        produceGroupNameItem.title = "精选商品"
        produceGroup.items.append(produceGroupNameItem)
        
        for goods in  HEShopCarTools.shareShopCarTools.getAllProduce()!{
            let produceItem = HECommonItemThreeLabel()
            produceItem.title = goods.name
            produceItem.secondTitle = "X"+"\(goods.userBuyNumber)"
            produceItem.thirdTitle = "￥\(goods.price!)"
            produceGroup.items.append(produceItem)
        }
        
        let total = HECommonItemOnlyRightLabel()
        total.subTitle = "合计:  ￥"+HEShopCarTools.shareShopCarTools.getTotalAmount()
        produceGroup.items.append(total)
        
        //费用明细
        let  detailsChargesGroup = HECommenGroup()
        let detailsChargesGroupNameItem = HECommonItemOnlyLeftLabel()
        detailsChargesGroupNameItem.title = "费用明细"
        detailsChargesGroup.items.append(detailsChargesGroupNameItem)
        
        let detailsChargesItem = HECommonItemDetailsCharges()
        detailsChargesItem.amount = "￥"+HEShopCarTools.shareShopCarTools.getTotalAmount()
        detailsChargesGroup.items.append(detailsChargesItem)

        groups = [couponGroup,payWayGroup,produceGroup,detailsChargesGroup]
    }

    private func buildFootView(){
        footView = HEShopCarFootView(frame: CGRectMake(0,view.height-HEShopCarFootView.footViewHeight-NavigationH,view.width,HEShopCarFootView.footViewHeight), buttonClicked: {
            ProgressHUD.showSuccessWithStatus("付款成功")
        })
        footView.determineButton.setTitle("确认付款", forState: .Normal)
        footView.totalAmount = HEShopCarTools.shareShopCarTools.getTotalAmount()
        view.addSubview(footView)
    }
}
