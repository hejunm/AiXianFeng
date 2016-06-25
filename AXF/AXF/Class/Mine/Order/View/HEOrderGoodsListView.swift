//
//  HEOrderGoodsListView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/12.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  订单详情， 商品列表信息

import UIKit

protocol HEOrderGoodsListViewDelegate {
    func heighChanged(height:CGFloat)
}

class HEOrderGoodsListView: UIView {
    
    private let costLabel = UILabel()
    private let lineView1 = UIView()
    private let orderGoodsView = OrderGoodsView() //商品列表
    private let feeListView = FeeListView()       //付款清单
    private let payMoneyView = PayMoneyView()     //实付
    
    var order: Order? {
        didSet {
            orderGoodsView.order_goods = order!.order_goods
            feeListView.fee_list = order!.fee_list
            payMoneyView.real_amount = order?.real_amount
        }
    }
    
    var delegate:HEOrderGoodsListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        costLabel.textColor = UIColor.lightGrayColor()
        costLabel.font = UIFont.systemFontOfSize(12)
        costLabel.text = "费用明细"
        addSubview(costLabel)
        
        lineView1.alpha = 0.1
        lineView1.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView1)
        
        addSubview(orderGoodsView)
        addSubview(feeListView)
        addSubview(payMoneyView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let leftMargin: CGFloat = 10
        costLabel.frame = CGRectMake(leftMargin, 0, width - leftMargin*2, 30)
        lineView1.frame = CGRectMake(leftMargin, CGRectGetMaxY(costLabel.frame), width - leftMargin, 1)
        orderGoodsView.frame = CGRectMake(0, CGRectGetMaxY(lineView1.frame), width, orderGoodsView.height)
        feeListView.frame = CGRectMake(0, CGRectGetMaxY(orderGoodsView.frame), width, feeListView.height)
        payMoneyView.frame = CGRectMake(0, CGRectGetMaxY(feeListView.frame), width, 40)
        height = CGRectGetMaxY(payMoneyView.frame)
        if delegate != nil{
            delegate?.heighChanged(height)
        }
    }
}



class OrderGoodsView :UIView{
    var lastViewY:CGFloat = 0
    var orderGoodsViewHeight:CGFloat = 0
    var order_goods: [[OrderGoods]]? {
        didSet{
            for subV in subviews{
                subV.removeFromSuperview()
            }
            
            for i in 0..<order_goods!.count {
                lastViewY += 10
                let array = order_goods![i]
                if array.count == 1 {
                    let goodsView = GoodsView(frame: CGRectMake(0, lastViewY, ScreenWidth, 20))
                    goodsView.orderGoods = array[0]
                    addSubview(goodsView)
                    lastViewY = CGRectGetMaxY(goodsView.frame) + 10
                } else if array.count > 1 {
                    for i in 0..<array.count {
                        let goodsView = GoodsView()
                        goodsView.frame = CGRectMake(0, lastViewY, ScreenWidth, 20)
                        goodsView.orderGoods = array[i]
                        addSubview(goodsView)
                        lastViewY = CGRectGetMaxY(goodsView.frame)
                    }
                    lastViewY += 10
                }
                let lineView = UIView()
                lineView.alpha = 0.1
                lineView.backgroundColor = UIColor.lightGrayColor()
                lineView.frame = CGRectMake(10, lastViewY, ScreenWidth - 10, 1)
                addSubview(lineView)
                lastViewY += 1
            }
            height = lastViewY //自动触发 superView 的layoutSubViews
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GoodsView:UIView{
    let titleLabel = UILabel()
    let numberLabel = UILabel()
    let priceLabel = UILabel()
    let giftImageView = UIImageView()
    
    var orderGoods: OrderGoods? {
        didSet {
            titleLabel.text = orderGoods?.name
            numberLabel.text = "x" + (orderGoods?.goods_nums)!
            priceLabel.text = "$" + (orderGoods?.goods_price)!
            if orderGoods?.is_gift != -1 {
                if orderGoods!.is_gift == 0 {
                    giftImageView.hidden = true //默认的
                } else if orderGoods!.is_gift == 1 {
                    giftImageView.hidden = false
                    priceLabel.hidden = true
                    setNeedsLayout()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20))
        
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.textColor = HETextBlackColor
        addSubview(titleLabel)
        
        numberLabel.font = UIFont.systemFontOfSize(14)
        numberLabel.textColor = HETextBlackColor
        addSubview(numberLabel)
        
        priceLabel.font = UIFont.systemFontOfSize(14)
        priceLabel.textColor = HETextBlackColor
        priceLabel.textAlignment = NSTextAlignment.Right
        addSubview(priceLabel)
        
        giftImageView.hidden = true
        giftImageView.image = UIImage(named: "jingxuan.png")
        addSubview(giftImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if giftImageView.hidden == false {
            giftImageView.frame = CGRectMake(10, (height - 15) * 0.5, 40, 15)
            titleLabel.frame = CGRectMake(CGRectGetMaxX(giftImageView.frame)+5, 0, width * 0.6-45, height)
            numberLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10, 0, 30, height)
        } else {
            titleLabel.frame = CGRectMake(10, 0, width * 0.6, height)
            numberLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10, 0, 30, height)
        }
        priceLabel.frame = CGRectMake(width - 60 - 10, 0, 60, 20)
    }
}

class FeeListView: UIView {
    let lineView1 = UIView()
    let lineView2 = UIView()
    
    var fee_list: [OrderFeeList]? {
        didSet {
            var viewH:CGFloat = 0
            if fee_list?.count > 1 {
                for i in 0..<fee_list!.count {
                    let feelView = FeeView(frame: CGRectMake(0, 10 + CGFloat(i) * 25, ScreenWidth, 25), fee: fee_list![i])
                    viewH = CGRectGetMaxY(feelView.frame)
                    addSubview(feelView)
                }
                height = viewH+10
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        lineView1.alpha = 0.1
        lineView1.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView1)
        
        lineView2.alpha = 0.1
        lineView2.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineView1.frame = CGRectMake(10, 0, width - 10, 1)
        lineView2.frame = CGRectMake(10, height - 1, width - 10, 1)
    }
}

class FeeView: UIView {
    
    private let titleLabel = UILabel()
    private let prictLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        
        titleLabel.textColor = HETextBlackColor
        titleLabel.font = UIFont.systemFontOfSize(14)
        addSubview(titleLabel)
        
        prictLabel.textColor = HETextBlackColor
        prictLabel.textAlignment = NSTextAlignment.Right
        prictLabel.font = UIFont.systemFontOfSize(14)
        addSubview(prictLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, fee: OrderFeeList) {
        self.init(frame: frame)
        titleLabel.text = fee.text
        prictLabel.text = "$" + (fee.value ?? "0")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRectMake(10, 0, width - 100, 25)
        prictLabel.frame = CGRectMake(width - 150, 0, 140, 25)
    }
}

class PayMoneyView:UIView{
    
    private let payMoneyLabel = UILabel()
    private let payLabel = UILabel()
    private let lineView = UIView()
    
    var real_amount:String?{
        didSet{
            payMoneyLabel.text = real_amount
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        payMoneyLabel.textColor = UIColor.redColor()
        payMoneyLabel.font = UIFont.systemFontOfSize(14)
        payMoneyLabel.textAlignment = NSTextAlignment.Center
        addSubview(payMoneyLabel)
        
        payLabel.textAlignment = NSTextAlignment.Right
        payLabel.textColor = HETextBlackColor
        payLabel.font = UIFont.systemFontOfSize(14)
        payLabel.text = "实付:"
        addSubview(payLabel)
        
        lineView.alpha = 0.1
        lineView.backgroundColor = UIColor.lightGrayColor()
        addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        payMoneyLabel.frame = CGRectMake(width-100, 0, 100, height)
        payLabel.frame = CGRectMake(CGRectGetMinX(payMoneyLabel.frame)-50, 0, 40, height)
        lineView.frame = CGRectMake(10, 0, width-10, 1)
    }
}