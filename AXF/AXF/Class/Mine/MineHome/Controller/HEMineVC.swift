//
//  HEMineVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/6.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMineVC: HEBaseViewController{

    //MARK: property
    private var headerView:HEMineVC_HeaderView!
    private var tableVC:HEMineVC_TabelVC!

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildHeaderView()
        buildTableVC()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    private func buildHeaderView(){
        weak var tempSelf = self
        headerView = HEMineVC_HeaderView(frame: CGRectMake(0, 0, view.width, HEMineVC_HeaderView.mineHeaderViewH), btnClick: {
            let settingVC = HEMineSettingVC()
            tempSelf!.navigationController?.pushViewController(settingVC, animated: true)
        })
        view.addSubview(headerView)
    }
    
    private func buildTableVC(){
        tableVC = HEMineVC_TabelVC()
        tableVC.view.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), view.width, view.height-headerView.height)
        tableVC.tableView.height = tableVC.view.height
        addChildViewController(tableVC)
        view.addSubview(tableVC.view)
        tableVC.didMoveToParentViewController(self)
        buildTableViewData()
        
        tableVC.tableHeaderView.delegate = self
    }
    
    private func buildTableViewData(){
        weak var tmpSelf = self
        //1
        let group1 = HECommenGroup()
        
        let address = HECommonItemArrow()
        address.iconName = "v2_my_address_icon"
        address.title = "我的收货地址"
        address.operationBlock = {
           tmpSelf!.navigationController?.pushViewController(HEMineAddressVC(), animated: true)
        }
        group1.items.append(address)
        
        let store = HECommonItemArrow()
        store.iconName = "icon_mystore"
        store.title = "我的店铺"
        store.operationBlock = {
            tmpSelf!.navigationController?.pushViewController(HEMineStoreVC(), animated: true)
        }
        group1.items.append(store)
        
        //2
        let group2 = HECommenGroup()
        
        let share = HECommonItemArrow()
        share.iconName = "v2_my_share_icon"
        share.title = "把乐先锋分享给好友"
        group2.items.append(share)
        
        //3
        let group3 = HECommenGroup()
        
        let help = HECommonItemArrow()
        help.iconName = "online_service"
        help.title = "客服帮助"
        help.operationBlock = {
            tmpSelf!.navigationController?.pushViewController(HEMineHelpVC(), animated: true)
        }
        group3.items.append(help)
        
        let feedback = HECommonItemArrow()
        feedback.iconName = "v2_my_feedback_icon"
        feedback.title = "意见反馈"
        feedback.operationBlock = {
            tmpSelf!.navigationController?.pushViewController(HEMineFeedbackVC(), animated: true)
        }
        group3.items.append(feedback)
        
        tableVC.groups = [group1,group2,group3]
    }
}

extension HEMineVC :HEMineVC_TableHeaderViewDelegate{
    func headerViewBtnClick(type:HEMineVC_TableHeaderViewBtnType){
        switch type {
        case .Order:
            navigationController?.pushViewController(HEMineOrderVC(), animated: true)
        case .Coupon:
            navigationController?.pushViewController(HEMineCouponVC(), animated: true)
        case .Message: 
            navigationController?.pushViewController(HEMineMessageVC(), animated: true)
        }
    }
}
