//
//  LeftImageRightTextButton.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/17.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class LeftImageRightTextButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFontOfSize(15)
        imageView?.contentMode = UIViewContentMode.Center
        setTitleColor(HETextBlackColor, forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRectMake(0, (height - (imageView?.size.height)!) * 0.5, (imageView?.size.width)!, (imageView?.size.height)!)
        titleLabel?.frame = CGRectMake((imageView?.size.width)! + 10, 0, width - (imageView?.size.width)! - 10, height)
    }
}
