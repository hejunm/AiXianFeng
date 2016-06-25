//
//  HEMineMessageVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  我的消息

import UIKit

class HEMineMessageVC: HEBaseViewController {

    private weak var systemTableView:UITableView!
    private weak var emptyView:UIView!
    private var message:[HEMessage]!{
        didSet{
            if message != nil{
                systemTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildNavi()
        buildSystemMsgTableView()
        loadSystemMsg()
    }
    
    private func buildNavi(){
        weak var tmpSelf = self
        let segmentedControl = HESegmentedControl(items: ["系统消息", "用户消息"]) { (index) in
            if index == 0{
                tmpSelf!.showSystemMessage()
            }else{
                tmpSelf!.showUserMessage()
            }
        }
        segmentedControl.size = CGSizeMake(180, 27)
        navigationItem.titleView = segmentedControl
    }
    
    private func buildSystemMsgTableView(){
        let tableView = UITableView(frame: view.frame, style: .Plain)
        tableView.height -= NavigationH
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = HEGlobalBackgroundColor
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        systemTableView = tableView
    }
    
    private func buildEmptyView(){
        let emptyView = UIView(frame: view.bounds)
        emptyView.backgroundColor = HEGlobalBackgroundColor
        
        let normalImageView = UIImageView(image: UIImage(named: "v2_my_message_empty"))
        normalImageView.center = view.center
        normalImageView.center.y -= 150
        emptyView.addSubview(normalImageView)
        
        let normalLabel = UILabel()
        normalLabel.text = "~~~并没有消息~~~"
        normalLabel.textAlignment = NSTextAlignment.Center
        normalLabel.frame = CGRectMake(0, CGRectGetMaxY(normalImageView.frame) + 10, ScreenWidth, 50)
        emptyView.addSubview(normalLabel)
        
        view.addSubview(emptyView)
        self.emptyView = emptyView
    }
    
    private func showSystemMessage(){
        systemTableView.hidden = false
        if emptyView != nil{
            emptyView.hidden = true
        }
    }
    
    private func showUserMessage(){
        systemTableView.hidden = true
        if emptyView == nil{
            buildEmptyView()
        }
        emptyView.hidden = false
    }
    
    private func loadSystemMsg(){
        weak var  tmpSelf = self
        HEMessageData.loadData(.System) { (data, error) in
            if data != nil{
                tmpSelf!.message = data.data
            }
        }
    }
}

extension HEMineMessageVC:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = HESystemMsgCell.getCell(tableView)
        cell.message = message[indexPath.row]
        return cell
    }
}
extension HEMineMessageVC:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let messageModel = message[indexPath.row]
        if messageModel.isSelected {
            return messageModel.selectedCellHeight
        }else{
            return messageModel.normalCellHeight
        }
    }
}
