//
//  HEHomeHorizontalCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHomeHorizontalCell: UICollectionViewCell {

    private var backImageView:UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backImageView = UIImageView();
        contentView.addSubview(backImageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backImageView.frame = bounds;
    }
    
    var activity:Activitie!{
        didSet{
            if activity==nil{ return; }
            backImageView.sd_setImageWithURL(NSURL(string: activity.img!), placeholderImage: UIImage(named: "v2_placeholder_full_size"))
        }
    }
}
