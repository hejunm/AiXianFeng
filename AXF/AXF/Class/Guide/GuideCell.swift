//
//  GuideCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class GuideCell: UICollectionViewCell {
    let imageView:UIImageView = UIImageView(frame: ScreenBounds)
    let btn:UIButton = UIButton(frame: CGRectMake((ScreenWidth - 100) * 0.5, ScreenHeight - 110, 100, 33))
    var image:UIImage?{
        didSet{
            imageView.image = image;
        }
    }
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(imageView)
        
        btn.setBackgroundImage(UIImage(named: "icon_next"), forState: UIControlState.Normal)
        btn.addTarget(self, action:"btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        btn.hidden = true
        contentView.addSubview(btn)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func btnClick(sender:UIButton){
        NSNotificationCenter.defaultCenter().postNotificationName(GuideViewControllerDidFinish, object: nil)
    }
    
    func hiddenBtn(hidden:Bool){
        btn.hidden = hidden
    }
}
