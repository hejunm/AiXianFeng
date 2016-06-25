//
//  HEMineOrderDetailVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/11.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMineOrderDetailVC: HEBaseViewController {
    private var scrollView: UIScrollView?
    private let orderDetailView = HEOrderDetialView()
    private let orderDetailUserView = HEOrderDetailUserView()
    private let orderGoodsListView = HEOrderGoodsListView()
    private var orderEvaluateView =  HEOrderEvaluateView(frame: CGRectMake(0, 0,ScreenWidth, 95))
    
    var order:Order!{
        didSet{
            orderDetailView.order = order
            orderDetailUserView.order = order
            orderGoodsListView.order = order
            orderEvaluateView.order = order
        }
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildScrollView()
        
        buildOrderDetailView()
        
        buildOrderDetailUserView()
        
        buildOrderGoodsListView()
        
        buildEvaluateView()
    }
    
    private func buildScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.height =  scrollView!.height  - NavigationH - 40
        scrollView?.alwaysBounceVertical = true
        scrollView?.backgroundColor = HEGlobalBackgroundColor
        scrollView?.contentSize = CGSizeMake(view.width, 1000)
        view.addSubview(scrollView!)
    }
    
    //订单详情信息
    private func buildOrderDetailView(){
        orderDetailView.frame = CGRectMake(0, 10, view.width, 185)
        scrollView?.addSubview(orderDetailView)
    }
    
    //订单中的用户信息
    private func buildOrderDetailUserView(){
        orderDetailUserView.frame = CGRectMake(0, CGRectGetMaxY(orderDetailView.frame) + 10, view.width, 110)
        scrollView?.addSubview(orderDetailUserView)
    }
    
    //订单中商品信息.
    private func buildOrderGoodsListView(){
        orderGoodsListView.frame = CGRectMake(0, CGRectGetMaxY(orderDetailUserView.frame) + 10, view.width, 0)
        orderGoodsListView.delegate = self
        scrollView?.addSubview(orderGoodsListView)
    }
    
    //评论
    private func buildEvaluateView(){
        scrollView?.addSubview(orderEvaluateView)
    }
}

//OrderGoodsListView 高度改变时回调
extension HEMineOrderDetailVC: HEOrderGoodsListViewDelegate{
    func heighChanged(height: CGFloat) {
        orderEvaluateView.y = CGRectGetMaxY(orderGoodsListView.frame) + 10
        scrollView?.contentSize = CGSizeMake(view.width, CGRectGetMaxY(orderEvaluateView.frame))
    }
}
