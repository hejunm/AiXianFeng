//
//  HECommonDetailsChargesCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/5.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonDetailsChargesCell: HECommonCell {
    
    private var amountDescLabel:UILabel!          ///商品总额
    private var amountLabel:UILabel!
    private var distributionCastDescLabel:UILabel!/// 配送费
    private var distributionCastLabel:UILabel!
    private var serviceCaseDescLabel:UILabel!     /// 服务费
    private var serviceCaseLabel:UILabel!
    private var couponDescLabel:UILabel!          /// 优惠券
    private var couponLabel:UILabel!
    
    override var itemModel: HECommenItem!{
        didSet{
            if let item = itemModel as? HECommonItemDetailsCharges{
                amountLabel.text = item.amount
                distributionCastLabel.text = item.distributionCast
                serviceCaseLabel.text = item.serviceCase
                couponLabel.text = item.coupon
            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let firstLabelX:CGFloat = 15
        var labelY:CGFloat = 10
        let labelWidth: CGFloat = (ScreenWidth - firstLabelX*2)/2
        let labelHeight:CGFloat = 20
        
        let secondLabelX = firstLabelX+labelWidth
        
        amountDescLabel =  buildLabel(CGRectMake(firstLabelX, labelY, labelWidth, labelHeight), text: "商品总额",textAlignment: NSTextAlignment.Left)
        amountLabel =  buildLabel(CGRectMake(secondLabelX, labelY, labelWidth,labelHeight), text: "", textAlignment: NSTextAlignment.Right)
        
        labelY = CGRectGetMaxY(amountDescLabel.frame)+5
        distributionCastDescLabel =  buildLabel(CGRectMake(firstLabelX, labelY, labelWidth, labelHeight), text: "配送费",textAlignment: NSTextAlignment.Left)
        distributionCastLabel =  buildLabel(CGRectMake(secondLabelX, labelY, labelWidth,labelHeight), text: "", textAlignment: NSTextAlignment.Right)
        
        labelY = CGRectGetMaxY(distributionCastDescLabel.frame)+5
        serviceCaseDescLabel =  buildLabel(CGRectMake(firstLabelX, labelY, labelWidth, labelHeight), text: "服务费",textAlignment: NSTextAlignment.Left)
        serviceCaseLabel =  buildLabel(CGRectMake(secondLabelX, labelY, labelWidth,labelHeight), text: "", textAlignment: NSTextAlignment.Right)
        
        labelY = CGRectGetMaxY(serviceCaseDescLabel.frame)+5
        couponDescLabel =  buildLabel(CGRectMake(firstLabelX, labelY, labelWidth, labelHeight), text: "优惠券",textAlignment: NSTextAlignment.Left)
        couponLabel =  buildLabel(CGRectMake(secondLabelX, labelY, labelWidth,labelHeight), text: "", textAlignment: NSTextAlignment.Right)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildLabel(labelFrame: CGRect, text: String, textAlignment: NSTextAlignment)->UILabel {
        let label = UILabel(frame: labelFrame)
        label.font = HEHomeCollectionTextFont
        label.textColor = UIColor.blackColor()
        label.text = text
        label.textAlignment = textAlignment
        contentView.addSubview(label)
        return label
    }
}
