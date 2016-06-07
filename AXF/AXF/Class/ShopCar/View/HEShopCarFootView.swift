//
//  HEShopCarFootView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  在购物车控制器根View上

import UIKit

class HEShopCarFootView: UIView {
    static let footViewHeight: CGFloat = 50
    
    let titleLabel = UILabel()
    let determineButton = UIButton()
    private let totalAmountLabel = UILabel()
    private var determineButtonClicked:(()->())?
 
    var totalAmount:String?{
        didSet{
            if totalAmount != nil{
                totalAmountLabel.text = totalAmount!
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        titleLabel.text = "共￥："
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.redColor()
        addSubview(titleLabel)
        
        totalAmountLabel.font = UIFont.systemFontOfSize(14)
        totalAmountLabel.textColor = UIColor.redColor()
        addSubview(totalAmountLabel)
        
        determineButton.backgroundColor = HENavigationYellowColor
        determineButton.setTitle("选好了", forState: UIControlState.Normal)
        determineButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        determineButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        determineButton.addTarget(self, action: #selector(HEShopCarFootView.btnClick), forControlEvents: .TouchUpInside)
        addSubview(determineButton)
    }
    
    convenience init(frame: CGRect,buttonClicked:(()->())?) {
        self.init(frame:frame)
        determineButtonClicked = buttonClicked
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRectMake(15, 0, titleLabel.width, height)
        determineButton.frame = CGRectMake(width-90, 0, 90, height)
        totalAmountLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame)+10, 0, width-90-10-CGRectGetMaxX(titleLabel.frame), height)
    }
    
    func btnClick(){
        if determineButtonClicked != nil{
            determineButtonClicked!()
        }
    }
}
