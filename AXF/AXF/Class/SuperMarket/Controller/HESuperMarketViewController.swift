//
//  SuperMarketViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  闪电超市

import UIKit

class HESuperMarketViewController: HESelectedAdressViewController {
    
    //MARK:property
    var categoryTableView:HETableView!
    var productsVC:HEProductViewController!
    
    var superMarketData:HESuperMarket!{  //数据
        didSet{
           productsVC.superMarketData = superMarketData
           categoryTableView.reloadData()
        }
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildCategoryTableView()
        buildProductsVC()
        
        loadData()
    }
    
    //MARK: private func
    private func buildCategoryTableView(){
        categoryTableView = HETableView(frame: CGRectMake(0, 0, view.width*0.25, view.height-NavigationH), style: .Plain)
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.backgroundColor = HEGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        view.addSubview(categoryTableView)
    }
    
    private func buildProductsVC(){
        productsVC = HEProductViewController()
        addChildViewController(productsVC) //"willMoveToParentViewController" is called for us
        view.addSubview(productsVC.view)
        productsVC.didMoveToParentViewController(self)
    }
    
    private func loadData(){
        weak var tmpSelf = self
        HESuperMarket.loadData { (data, error) -> Void in
            if data != nil{
                tmpSelf!.superMarketData = data
            }
        }
    }
}

//MARK:extension
extension HESuperMarketViewController :UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return superMarketData.data?.categories?.count ?? 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let category = superMarketData.data?.categories![indexPath.row]
        let cell = HECategoryCell.getCellFor(tableView: tableView)
        cell.categorie = category
        return cell
    }
}
extension HESuperMarketViewController :UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 45
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


