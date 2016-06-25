//
//  HEMineOrderCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/11.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMineOrderCell: UITableViewCell {
    
    //MARK: static
    private static let Id = "HEMineOrderCellId"
    class func getOrderCellFor(tableView:UITableView,orderModel:Order,indexPath:NSIndexPath) ->HEMineOrderCell{
        var cell:HEMineOrderCell?  = tableView.dequeueReusableCellWithIdentifier(Id) as? HEMineOrderCell
        if cell == nil{
            cell = HEMineOrderCell(style: .Default, reuseIdentifier: HEMineOrderCell.Id)
        }
        cell?.orderModel = orderModel
        cell?.indexPath = indexPath
        return cell!
    }
    
    //MARK: property
    private var indexPath:NSIndexPath?
    private var timeLabel: UILabel?
    private var statusTextLabel: UILabel?
    private var lineView1: UIView?
    private var goodsImageViews: OrderImageViews?
    private var lineView2: UIView?
    private var productNumsLabel: UILabel?
    private var productsPriceLabel: UILabel?
    private var payLabel: UILabel?
    private var lineView3: UIView?
    private var buttons: OrderButtonsView?
    private var orderModel:Order!{
        didSet{
            timeLabel?.text = orderModel?.create_time
            statusTextLabel?.text = orderModel?.textStatus
            goodsImageViews?.order_goods = orderModel?.order_goods
            productNumsLabel?.text = "共" + "\(orderModel!.buy_num)" + "件商品"
            productsPriceLabel?.text = "$" + (orderModel!.user_pay_amount)!
            buttons?.buttons = orderModel?.buttons
        }
    }
    
    //MARK: func
    override  init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.None
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.whiteColor()
        
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubView(){
        
        timeLabel = UILabel()
        timeLabel?.font = UIFont.systemFontOfSize(13)
        timeLabel?.textColor = UIColor.blackColor()
        contentView.addSubview(timeLabel!)
        
        statusTextLabel = UILabel()
        statusTextLabel?.textAlignment = NSTextAlignment.Right
        statusTextLabel?.font = timeLabel?.font
        statusTextLabel?.textColor = UIColor.redColor()
        contentView.addSubview(statusTextLabel!)
        
        goodsImageViews = OrderImageViews()
        contentView.addSubview(goodsImageViews!)
        
        productNumsLabel = UILabel()
        productNumsLabel?.textColor = UIColor.grayColor()
        productNumsLabel?.textAlignment = NSTextAlignment.Right
        productNumsLabel?.font = timeLabel?.font
        contentView.addSubview(productNumsLabel!)
        
        payLabel = UILabel()
        payLabel?.text = "实付:"
        payLabel?.textColor = UIColor.grayColor()
        payLabel?.font = productNumsLabel?.font
        contentView.addSubview(payLabel!)
        
        productsPriceLabel = UILabel()
        productsPriceLabel?.textColor = UIColor.blackColor()
        productsPriceLabel?.textAlignment = NSTextAlignment.Right
        productsPriceLabel?.font = payLabel?.font
        productsPriceLabel?.textColor = UIColor.grayColor()
        contentView.addSubview(productsPriceLabel!)
        
        buttons = OrderButtonsView(frame: CGRectZero, buttonClickCallBack: { (type) in
            
        })
        buttons!.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(buttons!)
        
        lineView1 = UIView()
        lineView1?.backgroundColor = UIColor.lightGrayColor()
        lineView1?.alpha = 0.1
        contentView.addSubview(lineView1!)
        
        lineView2 = UIView()
        lineView2?.backgroundColor = UIColor.lightGrayColor()
        lineView2?.alpha = 0.1
        contentView.addSubview(lineView2!)
        
        lineView3 = UIView()
        lineView3?.backgroundColor = UIColor.lightGrayColor()
        lineView3?.alpha = 0.1
        contentView.addSubview(lineView3!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 10
        let labelHeight: CGFloat = 30
        contentView.frame = CGRectMake(0, 0, width, height - 20)
        timeLabel?.frame = CGRectMake(margin, 0, 150, labelHeight)
        statusTextLabel?.frame = CGRectMake(width - 150, 0, 140, labelHeight)
        lineView1?.frame = CGRectMake(margin, CGRectGetMaxY(timeLabel!.frame), width - margin, 1)
        goodsImageViews?.frame = CGRectMake(0, CGRectGetMaxY(lineView1!.frame), width, 65)
        lineView2?.frame = CGRectMake(margin, CGRectGetMaxY(goodsImageViews!.frame), width - margin, 1)
       
        productsPriceLabel?.frame = CGRectMake(width - margin - 60, CGRectGetMaxY(lineView2!.frame), 60, labelHeight)
        payLabel?.frame = CGRectMake(CGRectGetMinX(productsPriceLabel!.frame)-40-margin, productsPriceLabel!.y, 40, labelHeight)
        productNumsLabel?.frame = CGRectMake(CGRectGetMinX(payLabel!.frame)-100-margin, productsPriceLabel!.y, 100, labelHeight)
        lineView3?.frame = CGRectMake(margin, CGRectGetMaxY(productNumsLabel!.frame), width - margin, 1)
        buttons?.frame = CGRectMake(0, CGRectGetMaxY(lineView3!.frame), width, 40)
    }
}

class OrderImageViews:UIView{
    private var imageViews:UIView!
    private var arrowImageView:UIImageView!
    var order_goods: [[OrderGoods]]!{
        didSet{
            if order_goods == nil {return}
            for i in 0..<order_goods.count {
                if i < 4 {
                    let subImageView = imageViews.subviews[i] as! UIImageView
                    subImageView.hidden = false
                    subImageView.sd_setImageWithURL(NSURL(string: order_goods![i][0].img!), placeholderImage: UIImage(named: "v2_placeholder_square"))
                }else{
                    break
                }
            }
            for var i = order_goods.count; i<4; i += 1 {
                let subImageView = imageViews.subviews[i] as! UIImageView
                subImageView.hidden = true
            }
            if order_goods?.count >= 5 {
                let subImageView = imageViews.subviews[4] as! UIImageView
                subImageView.hidden = false
            } else {
                let subImageView = imageViews.subviews[4] as! UIImageView
                subImageView.hidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageViews = UIView()
        for i in 0...4 {
            let imageView = UIImageView()
            if 4 == i {
                imageView.image = UIImage(named: "v2_goodmore")
            }
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            imageViews?.addSubview(imageView)
        }
        addSubview(imageViews)
        
        arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        addSubview(arrowImageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrowImageView.frame = CGRectMake(width-15, (height-arrowImageView.height)*0.5, arrowImageView.width, arrowImageView.height)
        
        imageViews.frame = CGRectMake(0, 5, width-15, height - 5*2)
        let eachImageViewW = (width-15)/5
        let eachImageViewH = imageViews.height
        for i in 0...4 {
            let imageView = imageViews.subviews[i] as! UIImageView
            imageView.frame = CGRectMake(eachImageViewW*CGFloat(i), 0, eachImageViewW, eachImageViewH)
        }
    }
}

class OrderButtonsView:UIView{
    var buttonClickCallBack: ((type: Int) -> ())?
    
    var buttons: [OrderButton]? {
        didSet {
            for subBtnView in subviews{
                subBtnView.removeFromSuperview()
            }
            
            let btnW: CGFloat = 60
            let btnH: CGFloat = 26
            
            for i in 0..<buttons!.count {
                let btn = UIButton(frame: CGRectMake(ScreenWidth - CGFloat(i + 1) * (btnW + 10) - 5, (self.height - btnH) * 0.5, btnW, btnH))
                btn.tag = i
                btn.titleLabel?.font = UIFont.systemFontOfSize(12)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = 5
                btn.backgroundColor = HENavigationYellowColor
                btn.setTitle(buttons![i].text, forState: UIControlState.Normal)
                btn.addTarget(self, action: #selector(OrderButtonsView.orderButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                addSubview(btn)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, buttonClickCallBack:(type: Int) -> ()) {
        self.init(frame: frame)
        self.buttonClickCallBack = buttonClickCallBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for i in 0..<subviews.count {
            let subBtnView = subviews[i]
            subBtnView.frame.origin.y = (self.height - 26) * 0.5
        }
    }
    
    func orderButtonClick(sender: UIButton) {
        if buttonClickCallBack != nil {
            buttonClickCallBack!(type: buttons![sender.tag].type)
        }
    }

}
