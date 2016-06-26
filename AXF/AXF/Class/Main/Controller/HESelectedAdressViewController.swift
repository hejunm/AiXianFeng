//
//  HESelectedAdressViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESelectedAdressViewController: HEAnimationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = HENavigationYellowColor
        buildNavigationItem()
        buildNoti()
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    private func buildNavigationItem(){
        navigationItem.leftBarButtonItem =  UIBarButtonItem.customItemWith("扫一扫", normalTitleColor: UIColor.blackColor(), image: UIImage(named: "icon_black_scancode")!, highlightedImage: nil,type:.Left, target: self, action: #selector(HESelectedAdressViewController.leftNavItemClick))
        navigationItem.rightBarButtonItem =  UIBarButtonItem.customItemWith("搜 索", normalTitleColor: UIColor.blackColor(), image: UIImage(named: "icon_search")!, highlightedImage: nil,type:.Right, target: self, action: #selector(HESelectedAdressViewController.rightNavItemClick))
        
        //自定义中间的titleView
        let titleView = HETitleViewForNavigationItem(frame: CGRectMake(0, 0, 0, 33))
        let address = HEUserInfo.shareUserInfo.addressData?.getDefaultAddress()
        titleView.setTitle(address?.address)
        let tapG = UITapGestureRecognizer(target: self, action: #selector(HESelectedAdressViewController.titleViewClick))
        titleView.addGestureRecognizer(tapG)
        navigationItem.titleView = titleView
    }
    private func buildNoti(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HESelectedAdressViewController.addressChanged(_:)), name: HENotiAddressChanged, object: nil)
    }
    
    //MARK: action
    func leftNavItemClick(){
        let qrCodeVC = HEQRCodeVC()
        navigationController?.pushViewController(qrCodeVC, animated: true)
    }
    
    func rightNavItemClick(){
        let searchVC = HESearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    func titleViewClick(){
        print("titleView click")
        navigationController?.pushViewController(HEMineAddressVC(), animated: true)
    }
    func addressChanged(noti:NSNotification){
        if let address = noti.userInfo?["address"] as? HEAddress{
            (navigationItem.titleView as! HETitleViewForNavigationItem).setTitle(address.address)
        }
    }
}
