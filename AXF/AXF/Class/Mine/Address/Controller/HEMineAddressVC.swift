//
//  HEMineAddressVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  我的地址

import UIKit

class HEMineAddressVC: HEBaseViewController {

    weak var addressTableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "我的地址"
        buildTableView()
        buildFootView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addressTableView?.reloadData()
    }
    
    private func buildTableView(){
        let tableView = UITableView(frame: CGRectMake(0, 0, view.width, view.height), style: .Plain)
        tableView.height = view.height-60-NavigationH
        tableView.rowHeight = 80
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        tableView.backgroundColor = HEGlobalBackgroundColor
        view.addSubview(tableView)
        self.addressTableView = tableView
    }
    
    private func buildFootView(){
        weak var tmpSelf = self
        let footView = HEAddressFootView(frame: CGRectMake(0, CGRectGetMaxY(addressTableView!.frame), view.width, 60)) {
            let editAddressVC = HEEditAddressVC()
            editAddressVC.vcType = HEEditAddressVCType.Add
            tmpSelf!.navigationController?.pushViewController(editAddressVC, animated: true)
        }
        view.addSubview(footView)
    }
}

extension HEMineAddressVC:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HEUserInfo.shareUserInfo.addressData?.getAllAddress()?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        weak var tmpSelf = self
        let cell = HEAddressCell.getCell(tableView) { (address) in
            let editAddressVC = HEEditAddressVC()
            editAddressVC.vcType = HEEditAddressVCType.Edit
            editAddressVC.address = HEUserInfo.shareUserInfo.addressData?.getAllAddress()?[indexPath.row]
            tmpSelf!.navigationController?.pushViewController(editAddressVC, animated: true)
        }
        cell.address =  HEUserInfo.shareUserInfo.addressData?.getAllAddress()?[indexPath.row]
        return cell
    }
}

extension HEMineAddressVC:UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let lastVCIndex = (navigationController?.childViewControllers.count)! - 2
        let lastVC = navigationController?.childViewControllers[lastVCIndex]
        if  lastVC!.isKindOfClass(HESelectedAdressViewController.self){
            let address = HEUserInfo.shareUserInfo.addressData?.getAllAddress()?[indexPath.row]
            HEUserInfo.shareUserInfo.addressData?.setDefaultAddress(address!)
            NSNotificationCenter.defaultCenter().postNotificationName(HENotiAddressChanged, object: nil, userInfo: ["address":address!])
            navigationController?.popViewControllerAnimated(true)
        }
    }
}
