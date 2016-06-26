//
//  HEDiscountPriceView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEDiscountPriceView: UIView {
    
    private var marketPriceLabel: UILabel?
    private var priceLabel: UILabel?
    private var lineView: UIView?
    private var hasMarketPrice = false
    
    var priceColor: UIColor? {
        didSet {
            if priceLabel != nil {
                priceLabel!.textColor = priceColor
            }
        }
    }
    var marketPriceColor: UIColor? {
        didSet {
            if marketPriceLabel != nil {
                marketPriceLabel!.textColor = marketPriceColor
                
                if lineView != nil {
                    lineView?.backgroundColor = marketPriceColor
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        marketPriceLabel = UILabel()
        marketPriceLabel?.textColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        marketPriceLabel?.font =  UIFont.systemFontOfSize(14)
        addSubview(marketPriceLabel!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.colorWithCustom(80, g: 80, b: 80)
        
        marketPriceLabel?.addSubview(lineView!)
        
        priceLabel = UILabel()
        priceLabel?.font =  UIFont.systemFontOfSize(14)
        priceLabel!.textColor = UIColor.redColor()
        addSubview(priceLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func set(price: String?, marketPrice: String?) {
        
        if price != nil && price?.characters.count != 0 {
            priceLabel!.text = "$" + price!.cleanDecimalPointZear()
            priceLabel!.sizeToFit()
        }
        
        if marketPrice != nil && marketPrice?.characters.count  != 0 {
            marketPriceLabel?.text = "$" + marketPrice!.cleanDecimalPointZear()
            hasMarketPrice = true
            marketPriceLabel?.sizeToFit()
        } else {
            hasMarketPrice = false
        }
        
        if marketPrice == price {
            hasMarketPrice = false
        } else {
            hasMarketPrice = true
        }
        marketPriceLabel?.hidden = !hasMarketPrice
        
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        priceLabel?.frame = CGRectMake(0, 0, priceLabel!.width, height)
        if hasMarketPrice {
            marketPriceLabel?.frame = CGRectMake(CGRectGetMaxX(priceLabel!.frame) + 5, 0, marketPriceLabel!.width, height)
            lineView?.frame = CGRectMake(0, marketPriceLabel!.height * 0.5 - 0.5, marketPriceLabel!.width, 1)
        }
    }
}
