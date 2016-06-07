//
//  HECommonOnlyLeftLabelCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/4.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonOnlyLeftLabelCell: HECommonCell {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = UIColor.lightGrayColor()
        textLabel?.font = UIFont.systemFontOfSize(12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
