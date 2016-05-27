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
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(self, action:"backBtnClick")
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    func backBtnClick(){
        popViewControllerAnimated(true)
    }
    
}
