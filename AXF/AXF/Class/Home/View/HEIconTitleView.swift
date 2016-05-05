//
//  HEIconTitleView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/5.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEIconTitleView: UIView {
    
    var imageView:UIImageView!
    var textLabel:UILabel!
    var placeHolderImage:UIImage!
    var activity:Activitie!{
        didSet{
            if activity == nil{
                print("HEIconTitleView activity空")
                return
            }
            textLabel.text = activity.name
            imageView.sd_setImageWithURL(NSURL(string: activity.img!), placeholderImage: placeHolderImage)
        }
    }
    
    
    //MARK: --初始化
    override init(frame: CGRect) { //高度：80, 宽度：ScreenWidth/4
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.contentMode = .Center
        imageView.userInteractionEnabled = false
        addSubview(imageView)
        
        textLabel = UILabel()
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.font = UIFont.systemFontOfSize(12)
        textLabel.textColor = UIColor.blackColor()
        textLabel.userInteractionEnabled = false
        addSubview(textLabel)
        
        let  tap = UITapGestureRecognizer(target: self, action: "iconClick")
        addGestureRecognizer(tap)
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect,placeHolderImage:UIImage) {
        self.init(frame:frame)
        self.placeHolderImage = placeHolderImage
    }
    
    //MARK: --布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRectMake(5, 5, width - 10, height - 30)
        textLabel?.frame = CGRectMake(5, height - 25, imageView.width, 20)
    }
    
    //MARK: --事件
    func iconClick(){
        NSNotificationCenter.defaultCenter().postNotificationName(HEHomeViewControllerIconClick, object: nil, userInfo: ["icons":activity])
    }
}
