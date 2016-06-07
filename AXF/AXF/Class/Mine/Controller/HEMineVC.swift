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
    private var headerView:HEMineHeaderView!
    private var tableVC:HEMineTableViewController!

    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.hidden = true
        buildHeaderView()
        buildTableVC()
    }
    
    private func buildHeaderView(){
        headerView = HEMineHeaderView(frame: CGRectMake(0, 0, view.width, HEMineHeaderView.mineHeaderViewH), btnClick: {
            print("seeting")
        })
        view.addSubview(headerView)
    }
    
    private func buildTableVC(){
        tableVC = HEMineTableViewController()
        tableVC.view.frame = CGRectMake(0, CGRectGetMaxY(headerView.frame), view.width, view.height-headerView.height)
        tableVC.tableView.height = tableVC.view.height
        view.addSubview(tableVC.view)
    }
}
