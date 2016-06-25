//
//  HEAddressFootView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/16.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEAddressFootView: UIView {
    
    private var addAddressClick:(()->())?
    private let btn = UIButton()
    
    init(frame: CGRect,addAddressClick:(()->())?) {
        super.init(frame: frame)
        self.addAddressClick = addAddressClick
        backgroundColor = UIColor.whiteColor()
        
        btn.backgroundColor = HENavigationYellowColor
        btn.setTitle("+ 新增地址", forState: .Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        btn.titleLabel?.font = UIFont.systemFontOfSize(15)
        btn.addTarget(self, action: #selector(HEAddressFootView.addAddress(_:)), forControlEvents:.TouchUpInside)
        addSubview(btn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRectMake(30, 10, width-30*2, height-10*2)
    }
    
    @objc private func addAddress(sender:UIButton){
        if addAddressClick != nil{
            addAddressClick!()
        }
    }
}
