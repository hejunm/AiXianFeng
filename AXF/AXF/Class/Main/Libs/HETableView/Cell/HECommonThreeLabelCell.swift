//
//  HECommonThreeLabelCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/5.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonThreeLabelCell: HECommonCell {
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        let textColor = UIColor.blackColor()
        let font = UIFont.systemFontOfSize(13)
        textLabel?.textColor = textColor
        textLabel?.font = font
        
        secondLabel.textColor = textColor
        secondLabel.font = font
        secondLabel.textAlignment = .Left
        
        thirdLabel.textColor = textColor
        thirdLabel.font = font
        thirdLabel.textAlignment = .Right
        
        contentView.addSubview(secondLabel)
        contentView.addSubview(thirdLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel?.frame = CGRectMake(HEMargin_10, 0, width * 0.6, height)
        secondLabel.frame = CGRectMake(CGRectGetMaxX(textLabel!.frame)+HEMargin_10, 0, 50, height)
        thirdLabel.frame = CGRectMake(width-70, 0, 60, height)
    }
    
    override var itemModel: HECommenItem!{
        didSet{
            if let item = itemModel as? HECommonItemThreeLabel{
                secondLabel.text = item.secondTitle
                thirdLabel.text = item.thirdTitle
            }
        }
    }
}
