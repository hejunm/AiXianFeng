//
//  HECommonCenterLabelCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonCenterLabelCell: HECommonCell {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        detailTextLabel?.hidden = true
        imageView?.hidden = true
        textLabel?.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.x = 0
        textLabel?.width = width
    }
}
