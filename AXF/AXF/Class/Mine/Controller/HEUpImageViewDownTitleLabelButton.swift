//
//  HEUpImageViewDownTitleLabelButton.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/6.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEUpImageViewDownTitleLabelButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRectMake(0, 0, width, height*0.6)
        imageView?.contentMode = UIViewContentMode.Center
        
        titleLabel?.frame = CGRectMake(0, height*0.6, width, height*0.3)
        titleLabel?.textAlignment = .Center
    }
}
