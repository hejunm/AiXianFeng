//
//  HEButtonForNavigationItem.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit


class HEButtonForLeftBarButtonItem: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let offset:CGFloat = 15
        imageView?.frame = CGRectMake(-offset, 0, width, height - 15)
        imageView?.contentMode = UIViewContentMode.Center
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-offset, height - 15, width, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
    }
}

class HEButtonForRightBarButtonItem: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let offset:CGFloat = 15
        imageView?.frame = CGRectMake(offset, 0, width, height - 15)
        imageView?.contentMode = UIViewContentMode.Center
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(offset, height - 15, width, (titleLabel?.height)!)
        titleLabel?.textAlignment = .Center
    }
}