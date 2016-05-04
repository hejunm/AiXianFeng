//
//  HETitleViewForNavigationItem.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/2.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HETitleViewForNavigationItem: UIView {
    
    private var playLabel = UILabel()
    private var titleLabel = UILabel()
    private var arrowImageView = UIImageView(image: UIImage(named: "allowBlack"))
    var titleViewWidth:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        playLabel.text="配送至"
        playLabel.textColor = HETextBlackColor
        playLabel.font = HENavigationTextViewFont
        playLabel.textAlignment = .Center
        playLabel.layer.borderWidth = 0.5
        playLabel.layer.borderColor = HETextBlackColor.CGColor
        playLabel.sizeToFit()
        self.addSubview(playLabel)
        
        titleLabel.textColor = HETextBlackColor
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.textAlignment = .Center
        titleLabel.text = "你在哪里？"
        titleLabel.sizeToFit()
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
    
    }
    
    func setTitle(title:String){
        titleLabel.text = title
        titleLabel.sizeToFit()
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let playLabelX:CGFloat = 3
        let playLabelY = (self.height - playLabel.height)/2-2  //居中位置
        playLabel.frame = CGRectMake(playLabelX,playLabelY, playLabel.width+4, playLabel.height+4)
        
        let titleLabelX = CGRectGetMaxX(playLabel.frame)+3
        let titleLabelY = (self.height - titleLabel.height)/2
        titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabel.width, titleLabel.height)
        
        let arrowImageViewX = CGRectGetMaxX(titleLabel.frame)+3
        let arrowImageViewY = (self.height - 6)/2
        arrowImageView.frame = CGRectMake(arrowImageViewX, arrowImageViewY, 10, 6)
        self.width = CGRectGetMaxX(arrowImageView.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
