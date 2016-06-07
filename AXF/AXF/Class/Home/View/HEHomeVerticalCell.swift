//
//  HEHomeVerticalCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHomeVerticalCell: UICollectionViewCell {

//MARK: 属性
    private lazy var goodsImageView: UIImageView = {
        return UIImageView()
    }();
    
    private lazy var nameLabel: UILabel = {
        let label =  UILabel()
        label.textAlignment = NSTextAlignment.Left
        label.font = HEHomeCollectionTextFont
        label.textColor = UIColor.blackColor()
        return label
    }();
    
    private lazy var fineImageView: UIImageView = {                     //精选 is_xf=1:是， 0:不是
        let imageView =  UIImageView(image: UIImage(named: "jingxuan.png"))
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    private lazy var pmDescLabel: UILabel = {                           //活动描述， had_pm=1：有活动
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = HEWhiteColor
        label.font = UIFont.systemFontOfSize(8)
        label.backgroundColor = UIColor.redColor()
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var specificsLabel: UILabel = {                        //单位
        let label = UILabel()
        label.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        label.font = UIFont.systemFontOfSize(12)
        label.textAlignment = .Left
        return label
    }()
    
    private lazy var priceLabel: UILabel = {                            //价格
        let label = UILabel()
        label.textColor = UIColor.redColor()
        label.textAlignment = .Left
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    private lazy var marketPriceLabel: DeleteLineLabel = {                      //商场价格 当和price相同时，不显示
        let label = DeleteLineLabel()
        label.textColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        label.textAlignment = .Left
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    private lazy var buyView: HEBuyView = {                                 //购买按钮
        let buyView = HEBuyView()
        return buyView
    }()
    
    /***添加商品到购物车的闭包 */
    func addGoodsToShopCerAnim(anim: ((UIImageView)->())!){
        weak var tmpSelf = self
        buyView.addButtonClick = {()->() in
            if anim != nil{
                anim(tmpSelf!.goodsImageView)
                //在这里发送添加商品都购物车的通知
                
            }
        }
    }
    
    var goods:Goods!{
        didSet{
            if goods == nil{ return}
            
            goodsImageView.sd_setImageWithURL(NSURL(string: goods.img!), placeholderImage: UIImage(named: "v2_placeholder_square"))
            nameLabel.text = goods.name
            pmDescLabel.text = goods.pm_desc
            specificsLabel.text = goods.specifics
            if goods.price != nil {
                priceLabel.text = "$\(goods.price!)"
            }
            if goods.market_price != nil{
                marketPriceLabel.text = "$\(goods.market_price!)"
            }
            buyView.goods = goods
            
            setNeedsLayout()
        }
    }
    
//MARK: 重写
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = HEWhiteColor
        contentView.addSubview(goodsImageView)     //商品图片
        contentView.addSubview(nameLabel)          //名称
        contentView.addSubview(fineImageView)      //精品
        contentView.addSubview(pmDescLabel)        //活动描述
        contentView.addSubview(specificsLabel)     //单位
        contentView.addSubview(priceLabel)         //价格
        contentView.addSubview(marketPriceLabel)   //超市价格
        contentView.addSubview(buyView)            //购买
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goodsImageView.frame = CGRectMake(0, 0, width, width)
        nameLabel.frame = CGRectMake(5, width, width-5, 20)
        if goods != nil{
            
            //精选
            if goods.is_xf == 1{
                fineImageView.hidden = false
                fineImageView.frame = CGRectMake(5, CGRectGetMaxY(nameLabel.frame)+3, 30, 15)
            }else{
                fineImageView.hidden = true
                fineImageView.frame = CGRectZero
            }
            
            //活动
            pmDescLabel.sizeToFit()
            let x = CGRectGetMaxX(fineImageView.frame)+5
            let y = CGRectGetMaxY(nameLabel.frame)+3
            let w = pmDescLabel.width+6
            let h:CGFloat = 15
            pmDescLabel.frame = CGRectMake(x, y, w, h)
            if goods.had_pm == 1{
                pmDescLabel.hidden = false
            }else{
                pmDescLabel.hidden = true
            }
            
            //单位
            specificsLabel.sizeToFit()
            specificsLabel.x = 5
            specificsLabel.y = CGRectGetMaxY(pmDescLabel.frame)+3
            
            //价格
            priceLabel.sizeToFit()
            priceLabel.x = 5
            priceLabel.y = CGRectGetMaxY(specificsLabel.frame)+3
            
            //超市价格
            if goods.price! != goods.market_price!{
                marketPriceLabel.sizeToFit()
                marketPriceLabel.hidden = false
                marketPriceLabel.x = CGRectGetMaxX(priceLabel.frame)+3
                marketPriceLabel.y = priceLabel.y
                marketPriceLabel.deleteLine.frame = CGRectMake(0, marketPriceLabel.height/2, marketPriceLabel.width, 1) //删除线
            }else{
                marketPriceLabel.hidden = true
            }
            
            //buyView
           buyView.frame = CGRectMake(width - 85, height - 30, 80, 25)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        goodsImageView.image = nil
        nameLabel.text = nil
        pmDescLabel.text = nil
        specificsLabel.text = nil
        marketPriceLabel.text = nil
    }
}

class DeleteLineLabel :UILabel {
    lazy var deleteLine:CALayer = {
        let layer = CALayer()
        layer.frame = CGRectZero
        layer.backgroundColor = UIColor.colorWithCustom(80, g: 80, b: 80).CGColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(deleteLine)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
