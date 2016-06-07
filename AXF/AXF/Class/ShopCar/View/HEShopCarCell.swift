//
//  HEShopCarCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/31.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEShopCarCell: UITableViewCell {

    static let Id = "HEShopCarCell"
    static let cellHeight: CGFloat = 50
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyView = HEBuyView()
    private let lineView = UIView()
    private var buyNumberZero:(()->())?{
        didSet{
            buyView.removeGoods = buyNumberZero
        }
    }
    
    var goods:Goods!{ //商品
        didSet{
            if goods == nil{ return}
            nameLabel.text = goods.name
            priceLabel.text = "$"+goods.price!
            priceLabel.sizeToFit()
            buyView.goods = goods
            layoutSubviews()
        }
    }
    
    /**
     获取购物车的cell
     
     - parameter tableView:     cell对应的tableView
     - parameter buyNumberZero: 当购买数量减为零时的闭包
     - returns: cell
     */
    class func getCellFor(tableView tableView:UITableView,buyNumberZero:(()->())?)->HEShopCarCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(Id) as? HEShopCarCell
        if cell == nil{
            cell = HEShopCarCell(style:.Default , reuseIdentifier: Id)
        }
        cell?.buyNumberZero = buyNumberZero
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        
        nameLabel.font = UIFont.systemFontOfSize(15)
        nameLabel.textColor = UIColor.blackColor()
        contentView.addSubview(nameLabel)
        
        priceLabel.textAlignment = NSTextAlignment.Right
        contentView.addSubview(priceLabel)
        
        contentView.addSubview(buyView)
        
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        contentView.addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buyView.frame = CGRectMake(width-85, (height-25)/2, 80, 25)
        priceLabel.frame = CGRectMake(CGRectGetMinX(buyView.frame)-priceLabel.width-5, 0, priceLabel.width, height)
        nameLabel.frame = CGRectMake(15, 0, CGRectGetMinX(priceLabel.frame)-15-5, height)
        lineView.frame = CGRectMake(10, height - 0.5, width - 10, 0.5)
    }
}
