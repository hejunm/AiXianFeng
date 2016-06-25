//
//  HEMineTableViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/6.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMineVC_TabelVC: HECommonTableViewController {
    
    var tableHeaderView:HEMineVC_TableHeaderView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableHeader()
    }
    
    private func buildTableHeader(){
        tableHeaderView = HEMineVC_TableHeaderView()
        tableHeaderView.frame = CGRectMake(0, 0, view.width, 70)
        tableView?.tableHeaderView = tableHeaderView
    }
}


