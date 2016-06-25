//
//  HEMineOrderVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  我的订单

import UIKit

class HEMineOrderVC: HEBaseViewController {
    private var tableView:UITableView!
    var orders: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的订单"
        view.backgroundColor = HEGlobalBackgroundColor
        buildTableView()
        loadData()
    }
    
    private func buildTableView(){
        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.height = tableView.height - NavigationH
        tableView.backgroundColor = UIColor.clearColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        view.addSubview(tableView)
    }
    
    private func loadData(){
        weak var tmpSelf = self
        OrderData.loadData { (data, error) in
            if data == nil{return}
            tmpSelf!.orders = data.data
            tmpSelf!.tableView.reloadData()
        }
    }
}

extension HEMineOrderVC:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let order = orders![indexPath.row]
        let cell = HEMineOrderCell.getOrderCellFor(tableView,orderModel:order,indexPath: indexPath)
        return cell
    }
}

extension HEMineOrderVC:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 185.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderStatusVC = HEMineOrderStatusVC()
        orderStatusVC.order = orders![indexPath.row]
        navigationController?.pushViewController(orderStatusVC, animated: true)
    }
}
