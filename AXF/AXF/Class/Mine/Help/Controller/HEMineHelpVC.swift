//
//  HEMineHelpVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMineHelpVC: HECommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        navigationItem.title = "客户帮助"
        buildGroup()
    }
    
    private func buildGroup(){
        
        weak var tmpSelf = self
        let group = HECommenGroup()
        
        //1
        let item1 = HECommonItemArrow()
        item1.title = "客服电话：400-8484-842"
        item1.operationBlock = {
            let alertView = UIAlertView(title: "", message: "400-8484-842", delegate: tmpSelf!, cancelButtonTitle: "取消", otherButtonTitles: "拨打")
            alertView.show()
        }
       
        //2
        let item2 = HECommonItemArrow()
        item2.title = "常见问题"
        item2.operationBlock = {
            let helpDetailVC = HEMineHelpDetailVC()
            tmpSelf!.navigationController?.pushViewController(helpDetailVC, animated: true)
        }
        group.items.append(item1)
        group.items.append(item2)
        self.groups = [group]
    }
}

extension HEMineHelpVC:UIAlertViewDelegate{
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            UIApplication.sharedApplication().openURL(NSURL(string: "tel:4008484842")!)
        }
    }
}
