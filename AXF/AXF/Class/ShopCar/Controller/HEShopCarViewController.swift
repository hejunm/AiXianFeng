//
//  HEShopCarViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEShopCarViewController: HEBaseViewController {
    private let footViewHeight: CGFloat = 50
    
    var emptyView:HEEmptyGoodsView!
    var tableView:HEShopCarTableView!
    var footView:HEShopCarFootView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HEGlobalBackgroundColor
        buildNoti()
        buildNavigationItem()
        buildEmptyGoodsView()
        buildShopCarTableView()
        buildFootView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        selectView()
    }
    
    
    private func buildNoti(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HEShopCarViewController.selectView), name: HENotiShopCarNoProduce, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HEShopCarViewController.setTotalAmount), name: HENotiShopCarTotalAmountChanged, object: nil)
        
    }
    
    private func buildNavigationItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.backBarButtonItem(self, action:#selector(HEShopCarViewController.backBtnClick))
        navigationItem.title = "购物车"
    }
    
    private func buildEmptyGoodsView(){
        emptyView = HEEmptyGoodsView()
        emptyView.frame = view.bounds
        emptyView.addTarget(self, action: #selector(HEShopCarViewController.backBtnClick))
        view.addSubview(emptyView)
    }
    
    private func buildShopCarTableView(){
        tableView = HEShopCarTableView(frame: CGRectMake(0, 0, view.width, view.height-NavigationH), style: .Plain)
        tableView.backgroundColor = HEGlobalBackgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: footViewHeight, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        view.addSubview(tableView)
    }
    
    private func buildFootView(){
        weak var tmpSelf = self
        footView = HEShopCarFootView(frame: CGRectMake(0,view.height-footViewHeight-NavigationH,view.width,footViewHeight), buttonClicked: {
            let choicePayWayVC = HEChoicePayWayViewController()
            tmpSelf?.navigationController?.pushViewController(choicePayWayVC, animated: true)
        })
        setTotalAmount()
        view.addSubview(footView)
    }
    
    /**action*/
    func backBtnClick() {
        dismissViewControllerAnimated(true) { }
    }
    
    /** 根据购物车中的数据选择要显示的界面*/
    func selectView(){
        if HEShopCarTools.shareShopCarTools.getProduceCount() == 0{
            emptyView.hidden = false
            tableView.hidden = true
            footView.hidden = true
        }else{
            emptyView.hidden = true
            tableView.hidden = false
            footView.hidden = false
            tableView.reloadData()
        }
    }
    
    /** 购买商品的总金额发生改变*/
    func setTotalAmount(){
        footView.totalAmount = HEShopCarTools.shareShopCarTools.getTotalAmount()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

extension HEShopCarViewController:UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HEShopCarTools.shareShopCarTools.getProduceCount()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell  = HEShopCarCell.getCellFor(tableView: tableView) {
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
        cell.goods = HEShopCarTools.shareShopCarTools.getAllProduce()![indexPath.row]
        return cell
    }
}

extension HEShopCarViewController:UITableViewDelegate{
    
}

