//
//  HEHeaderCommentView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  备注

import UIKit

class HEHeaderCommentView: UIView {
    
    var textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        addSubview(lineView(CGRectMake(0, 0, width, 0.5)))
        
        let label = UILabel()
        label.text = "收货备注"
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(15)
        label.sizeToFit()
        label.frame = CGRectMake(15, 0, label.width, height)
        addSubview(label)
        
        textField.placeholder = "可输入100字以内特殊要求内容"
        textField.frame = CGRectMake(CGRectGetMaxX(label.frame) + 10, 10, width - CGRectGetMaxX(label.frame) - 10 - 20, height - 20)
        textField.font = UIFont.systemFontOfSize(15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        addSubview(textField)
        
        addSubview(lineView(CGRectMake(0, height-0.5, width, 0.5)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func lineView(frame: CGRect) -> UIView {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        return lineView
    }
}
