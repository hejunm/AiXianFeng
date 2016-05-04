//
//  HESelectedAdressViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESelectedAdressViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = HENavigationYellowColor
        
        buildNavigationItem()
    }
    
    private func buildNavigationItem(){
        navigationItem.leftBarButtonItem =  UIBarButtonItem.customItemWith("扫一扫", normalTitleColor: UIColor.blackColor(), image: UIImage(named: "icon_black_scancode")!, highlightedImage: nil,type:.Left, target: self, action: "leftNavItemClick")
        navigationItem.rightBarButtonItem =  UIBarButtonItem.customItemWith("搜 索", normalTitleColor: UIColor.blackColor(), image: UIImage(named: "icon_search")!, highlightedImage: nil,type:.Right, target: self, action: "rightNavItemClick")
        
        //自定义中间的titleView
        let titleView = HETitleViewForNavigationItem(frame: CGRectMake(0, 0, 0, 33))
        let tapG = UITapGestureRecognizer(target: self, action: "titleViewClick")
        titleView.addGestureRecognizer(tapG)
        navigationItem.titleView = titleView
    }
    
    func leftNavItemClick(){}
    
    func rightNavItemClick(){}
    
    func titleViewClick(){
        print("titleView")
    }
}
