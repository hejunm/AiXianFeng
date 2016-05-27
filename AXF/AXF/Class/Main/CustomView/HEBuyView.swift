//
//  HEBuyView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/13.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEBuyView: UIView {
    
    //添加按钮
    private lazy var addGoodsButton:UIButton = {
        let addGoodsButton = UIButton(type: .Custom)
        addGoodsButton.setImage(UIImage(named: "v2_increase"), forState: .Normal)
        addGoodsButton.addTarget(self, action: "addGoodsButtonClick", forControlEvents: .TouchUpInside)
        return addGoodsButton
    }()
    
    //删除按钮
    private lazy var reduceGoodsButton:UIButton = {
        let reduceGoodsButton = UIButton(type: .Custom)
        reduceGoodsButton.setImage(UIImage(named: "v2_reduce"), forState: .Normal)
        reduceGoodsButton.addTarget(self, action: "reduceGoodsButtonClick", forControlEvents: .TouchUpInside)
        return reduceGoodsButton
    }()
    
    //购买商品数量
    private lazy var buyCountLabel:UILabel = {
        let buyCountLabel = UILabel()
        buyCountLabel.hidden = false
        buyCountLabel.text = "0"
        buyCountLabel.textColor = UIColor.blackColor()
        buyCountLabel.textAlignment = NSTextAlignment.Center
        buyCountLabel.font = HEHomeCollectionTextFont
        return buyCountLabel
    }()
    
    //补货中
    private lazy var supplementLabel:UILabel = {
        let supplementLabel = UILabel()
        supplementLabel.text = "补货中"
        supplementLabel.hidden = true
        supplementLabel.textAlignment = NSTextAlignment.Right
        supplementLabel.textColor = UIColor.redColor()
        supplementLabel.font = HEHomeCollectionTextFont
        supplementLabel.sizeToFit()
        return supplementLabel
    }()
    
    var goods:Goods!{             //商品信息
        didSet{
            if goods.number<=0{
                showSupplementLabel()
            }else{
                hideSupplementLabel()
            }
            buyNumber = goods.userBuyNumber
        }
    }
    
    var buyNumber:Int = 0{   //添加到购物车中的数量
        didSet{
            if buyNumber<=0{
                reduceGoodsButton.hidden = true
                buyCountLabel.hidden = true
            }else{
                reduceGoodsButton.hidden = false
                buyCountLabel.hidden = false
                buyCountLabel.text = "\(buyNumber)"
            }
            
            //在cell重新赋值时，不丢失已购信息（其实在内存中，退出应用后，还是会丢失。这里应该使用数据库）
            goods.userBuyNumber = buyNumber
        }
    }
    
    var addButtonClick:(()->())! //添加按钮单击后执行闭包
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(addGoodsButton)
        addSubview(reduceGoodsButton)
        addSubview(buyCountLabel)
        addSubview(supplementLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGoodsButton.frame = CGRectMake(width-height-2, 0, height, height)
        buyCountLabel.frame = CGRectMake(height, 0, width-height*2-2, height)
        reduceGoodsButton.frame = CGRectMake(0, 0, height, height)
        
        supplementLabel.x = width - supplementLabel.width //补货
        supplementLabel.y = 0
        supplementLabel.height = height
    }
    
    func addGoodsButtonClick(){
        if buyNumber >= goods.number{ //库存不足
            ProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "\(goods.name!)库存不足了\n先买这么多, 过段时间再来看看吧~")
        }else{
            buyNumber++
            if addButtonClick != nil{
                addButtonClick()
            }
        }
    }
    
    func reduceGoodsButtonClick(){
        buyNumber--
    }
    
    //显示补货信息
    private func showSupplementLabel(){
        supplementLabel.hidden = false
        addGoodsButton.hidden = true
        buyCountLabel.hidden = true
        reduceGoodsButton.hidden = true
    }
    
    //隐藏补货信息
    private func hideSupplementLabel(){
        supplementLabel.hidden = true
        addGoodsButton.hidden = false
        buyCountLabel.hidden = false
        reduceGoodsButton.hidden = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
