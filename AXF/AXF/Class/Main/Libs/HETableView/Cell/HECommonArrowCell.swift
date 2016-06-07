//
//  HECommonItemArrowCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/4.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonArrowCell: HECommonCell {
    
    private let  arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        accessoryView = arrowImageView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        arrowImageView.size = CGSizeMake(5, 10)
    }
}