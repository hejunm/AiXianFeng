//
//  HEHomeCollectionFootView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/13.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHomeCollectionFootView: UICollectionReusableView {
    lazy var label:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = UIColor.colorWithCustom(150, g: 150, b: 150)
        label.textAlignment = .Center
        label.text = "点击查看更多商品 >"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showLable(){
        label.hidden = false
    }
    
    func hideLabel(){
        label.hidden = true
    }
    
    func setLabelText(str:String){
        label.text = str
    }
}

class HEHomeCollectionHeaderView:UICollectionReusableView{
    lazy var label:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = UIColor.colorWithCustom(150, g: 150, b: 150)
        label.text = "新鲜热卖"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        label.x = 10
    }
}