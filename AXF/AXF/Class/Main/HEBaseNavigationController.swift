//
//  HEBaseNavigationController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEBaseNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = getCustomBarButtonItem()
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    private func getCustomBarButtonItem()->UIBarButtonItem{
        
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.setImage(UIImage(named: "v2_goback"), forState: .Normal)
        backBtn.titleLabel?.hidden = true
        backBtn.addTarget(self, action: "backBtnClick", forControlEvents: .TouchUpInside)
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        backBtn.frame = CGRectMake(0, 0, btnW, 40)
        return UIBarButtonItem(customView: backBtn)
    }
    
    func backBtnClick(){
        popViewControllerAnimated(true)
    }
    
}
