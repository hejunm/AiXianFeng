//
//  HEShopCatTableView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEShopCarTableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        registerClass(HEShopCarCell.self, forCellReuseIdentifier: HEShopCarCell.Id)
        buileHeaderView() //创建headerView
        tableFooterView = UIView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buileHeaderView(){
        
        tableHeaderView = UIView(frame: CGRectMake(0,0,width,250))
        //收货地址
        let receiptAddressView =  HEHeaderReceiptAddressView(frame: CGRectMake(0,HEMargin_10,width,70)) {
        }
        receiptAddressView.address = HEUserInfo.shareUserInfo.addressData?.getDefaultAddress()
        tableHeaderView!.addSubview(receiptAddressView)
        //闪电超市
        let superMarketView = HEHeaderSuperMarketView(frame: CGRectMake(0,CGRectGetMaxY(receiptAddressView.frame)+HEMargin_10,width,60))
        tableHeaderView!.addSubview(superMarketView)
        //可预订
        let reserveView = HEHeaderReserveView(frame: CGRectMake(0,CGRectGetMaxY(superMarketView.frame),width,50))
        tableHeaderView!.addSubview(reserveView)
        //备注
        let commentView = HEHeaderCommentView(frame: CGRectMake(0,CGRectGetMaxY(reserveView.frame),width,50))
        tableHeaderView!.addSubview(commentView)
    }
}
