//
//  HECommonOnlyRightLabelCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/5.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonOnlyRightLabelCell: HECommonCell {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        detailTextLabel?.textColor = UIColor.redColor()
        textLabel?.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
