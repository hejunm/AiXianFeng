//
//  HEMineOrderStatusVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/11.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  订单状态流

import UIKit

class HEMineOrderStatusVC: HEBaseViewController {

    //MARK: property
    private let footViewHeight:CGFloat = 40
    private var orderStatusTableView:UITableView!
    private var orderDetailVc:HEMineOrderDetailVC!
    
    private var orderStatus:[OrderStatus]?{ //订单状态时间流
        didSet{
            if orderStatus == nil {return}
            orderStatusTableView?.reloadData()
        }
    }
    
    var order:Order!{
        didSet{
            if order == nil{ return}
            orderStatus = order.status_timeline
        }
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildNavi()
        buildOrderStatusTableView()
        buildFootView()
    }
    
    //MARK: private func
    private func buildNavi(){
        let rightItem = UIBarButtonItem.barButton("投诉", titleColor: HETextBlackColor, target: self, action: #selector(HEMineOrderStatusVC.rightItemButtonClick))
        navigationItem.rightBarButtonItem = rightItem
        
        weak var tmpSelf = self
        let segmentedControl = HESegmentedControl(items: ["订单状态", "订单详情"]) { (index) in
            if index == 0{
                tmpSelf!.showOrderStatus()
            }else{
                tmpSelf!.showOrderDetail()
            }
        }
        segmentedControl.size = CGSizeMake(180, 27)
        navigationItem.titleView = segmentedControl
    }
    
    private func buildOrderStatusTableView(){
        orderStatusTableView = UITableView(frame: CGRectMake(0, 0, view.width, view.height), style: .Plain)
        orderStatusTableView.height = orderStatusTableView.height -  NavigationH - footViewHeight
        orderStatusTableView.rowHeight = 80
        orderStatusTableView.delegate = self
        orderStatusTableView.dataSource = self
        orderStatusTableView.tableFooterView = UIView()
        orderStatusTableView.separatorStyle = .None
        view.addSubview(orderStatusTableView)
    }
    
    private func buildOrderDetailVc(){
        orderDetailVc = HEMineOrderDetailVC()
        orderDetailVc.order = order
        orderDetailVc.view.frame = CGRectMake(0, 0, view.width, view.height-footViewHeight)
        addChildViewController(orderDetailVc)
        view.addSubview(orderDetailVc.view)
        orderDetailVc.didMoveToParentViewController(self)
    }
    
    private func buildFootView(){
        let footView = UIView(frame: CGRectMake(0,CGRectGetMaxY(orderStatusTableView.frame),view.width,footViewHeight))
        footView.backgroundColor = UIColor.whiteColor()
        
        let lineView = UIView(frame: CGRectMake(0,0,footView.width,1))
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        footView.addSubview(lineView)
        
        let btn = UIButton(frame: CGRectMake(footView.width - 80-20,(footView.height-30)*0.5,80,30))
        btn.setTitle("删除订单", forState: UIControlState.Normal)
        btn.backgroundColor = HENavigationYellowColor
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.layer.cornerRadius = 5;
        footView.addSubview(btn)
        view.addSubview(footView)
    }
    
    /** 显示订单状态*/
    private func showOrderStatus(){
        orderStatusTableView.hidden = false
        if orderDetailVc != nil{
            orderDetailVc.view.hidden = true
        }
    }
    
    /** 显示订单详情*/
    private func showOrderDetail(){
        orderStatusTableView.hidden = true
        if orderDetailVc == nil{
            buildOrderDetailVc()
        }
        orderDetailVc.view.hidden = false
    }
    
    //MARK: action
    func rightItemButtonClick(){
        print("投诉")
    }
}

extension HEMineOrderStatusVC:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatus?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HEMineOrderStatusCell.orderStatusCell(tableView)
        cell.orderStatus = orderStatus![indexPath.row]
        if indexPath.row == 0{
            cell.orderStateType = .Top
        }else if indexPath.row == orderStatus!.count - 1 {
            cell.orderStateType = .Bottom
        }else{
            cell.orderStateType = .Middle
        }
        return cell
    }
}

extension HEMineOrderStatusVC:UITableViewDelegate{
   
}
