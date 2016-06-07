//
//  HECommenTableViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/2.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  数据驱动， 可用于展示各种cell的tableView

import UIKit

class HECommonTableViewController: UIViewController {
    var tableView:UITableView!
    var groups:[HECommenGroup]!{
        didSet{
            if groups == nil {return}
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
    }

    private func buildTableView(){
        tableView = UITableView(frame: view.bounds, style: .Grouped)
        tableView.sectionFooterHeight = HEMargin_10
        tableView.separatorStyle = .SingleLine
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}

extension HECommonTableViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = groups[section]
        return group.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let itemModel = groups[indexPath.section][indexPath.row]
        let cell =  HECommonCell.getCellForTableView(tableView, itemModel: itemModel)
        return cell
    }
}
extension HECommonTableViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let itemModel =  groups[indexPath.section][indexPath.row]
        return itemModel.height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let group = groups[indexPath.section]
        let itemModel = group[indexPath.row]
        
        //如果是CheckBoxGroup,里面的内容是单选的
        if  group is HECommonCheckBoxGroup && itemModel is HECommonItemSwitch{            NSNotificationCenter.defaultCenter().postNotificationName(HENotiCheckBoxGroupSelectChanged, object: group, userInfo: ["itemModel":itemModel])
        }
        
        if let destVcClass =  itemModel.destVcClass{ //跳转的控制器
            navigationController?.pushViewController(destVcClass, animated: true)
            return
        }
        if itemModel.operationBlock != nil{ //闭包
            itemModel.operationBlock!()
            return
        }
    }
}
