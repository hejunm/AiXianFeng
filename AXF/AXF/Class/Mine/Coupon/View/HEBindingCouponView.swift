//
//  HEBindingCouponView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/13.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEBindingCouponView: UIView {
    
    var binding:(String? ->())?
    private let couponTextField = UITextField()
    private let btn = UIButton(type: UIButtonType.Custom)
    private let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        couponTextField.keyboardType = UIKeyboardType.NumberPad
        couponTextField.borderStyle = UITextBorderStyle.RoundedRect
        couponTextField.autocorrectionType = UITextAutocorrectionType.No
        couponTextField.font = UIFont.systemFontOfSize(14)
        let placeholder = NSAttributedString(string: "请输入优惠劵号码", attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14), NSForegroundColorAttributeName : UIColor(red: 50 / 255.0, green: 50 / 255.0, blue: 50 / 255.0, alpha: 0.8)])
        couponTextField.attributedPlaceholder = placeholder
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = HENavigationYellowColor
        btn.setTitle("绑定", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.addTarget(self, action: #selector(HEBindingCouponView.bindingButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.2
        
        addSubview(couponTextField)
        addSubview(btn)
        addSubview(lineView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(frame: CGRect,binding:(String? ->())) {
        self.init(frame:frame)
        self.binding = binding
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 10
        let btnWidth: CGFloat = 60
        btn.frame = CGRectMake(width - margin - btnWidth, margin, btnWidth, height - margin*2)
        couponTextField.frame = CGRectMake(margin, margin, CGRectGetMinX(btn.frame)-margin*2, height - margin*2)
        lineView.frame = CGRectMake(0, height - 0.5, width, 0.5)
    }
    
    func bindingButtonClick(){
        if binding != nil{
            binding!(couponTextField.text)
        }
    }
}
