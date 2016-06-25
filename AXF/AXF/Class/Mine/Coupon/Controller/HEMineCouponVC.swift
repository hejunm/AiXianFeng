//
//  HEMineCouponVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  优惠券

import UIKit

class HEMineCouponVC: HEBaseViewController {
    
    private weak var bindingCouponView:HEBindingCouponView!
    private weak var couponTableView:UITableView!
    private  var  couponModels:[Coupon]?{
        didSet{
            couponTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        buildNavi()
        buildBindingCouponView()
        buildCouponTableView()
        loadData()
    }

    private func buildNavi(){
        navigationItem.title = "优惠券"
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("使用说明", titleColor: UIColor.colorWithCustom(100, g: 100, b: 100), target: self, action: #selector(HEMineCouponVC.instructionClick))
    }
    
    private func buildBindingCouponView(){
        let bindingCouponView = HEBindingCouponView(frame:  CGRectMake(0, 0, view.width, 50)) { (couponNum) in
            if couponNum == nil || couponNum?.isEmpty == true{
                ProgressHUD.showErrorWithStatus("请输入优惠券码")
                return
        }
            ProgressHUD.showSuccessWithStatus("优惠券码\(couponNum!)")
        }
        view.addSubview(bindingCouponView)
        self.bindingCouponView = bindingCouponView
    }
    
    private func buildCouponTableView(){
        let tableView = UITableView(frame: CGRectMake(0, CGRectGetMaxY(bindingCouponView.frame), view.width, view.height-bindingCouponView.height-NavigationH), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        view.addSubview(tableView)
        self.couponTableView = tableView
    }
    
    private func loadData(){
        weak var tmpSelf = self
        HECouponData.loadData({ (data, error) in
            if  data != nil{
               tmpSelf?.couponModels = data.data
            }
        })
    }
    //action, 使用说明
    func instructionClick(){
        let instructionVC = HEWebViewController(title: "使用规则", url: HECouponUserRuleURLString)
        navigationController?.pushViewController(instructionVC, animated: true)
    }
}
extension HEMineCouponVC:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return couponModels?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let couponModel = couponModels![indexPath.row]
        let cell = HECouponCell.getCellFor(tableView,couponData: couponModel)
        return cell
    }
}
extension HEMineCouponVC:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
}
