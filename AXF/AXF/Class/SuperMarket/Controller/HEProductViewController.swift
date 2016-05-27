//
//  HEProductViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEProductViewController: HEAnimationController {
    
    //MARK: property
    private var produceTableView:UITableView!
    var superMarketData:HESuperMarket!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = UIView(frame: CGRectMake(ScreenWidth*0.25, 0, ScreenWidth*0.75, ScreenHeight-NavigationH))
        buildProduceTableView()
    }
    
    override func didMoveToParentViewController(parent: UIViewController?) {
        super.didMoveToParentViewController(parent)
        produceTableView.frame = view.bounds
        produceTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: HETabBarH, right: 0)
        produceTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: HETabBarH, right: 0)
    }
    
    //MARK: private func
    private func buildProduceTableView(){
        produceTableView = UITableView(frame: CGRectZero, style: .Plain)
        produceTableView.delegate = self
        produceTableView.dataSource = self
        view.addSubview(produceTableView)
    }
}

extension HEProductViewController:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return superMarketData.getCategories().count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return superMarketData.getGoodsArrayForCategoryAt(index: section).count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = HEProductCell.getCellFor(tableView: tableView)
        let goods = superMarketData.getGoodsArrayForCategoryAt(index: indexPath.section)[indexPath.row]
        cell.goods = goods
        weak var tmpSelf = self
        cell.addGoodsToShopCerAnim({ (imageView) -> () in //添加商品时的动画
            tmpSelf?.addProductsAnimation(imageView)
        })
        return cell
    }
}

extension HEProductViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // --UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        cleanAllAnimationLayers()
    }
}