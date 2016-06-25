//
//  HeHelpQuestionHeaderView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/15.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  帮助，问题中心 用于显示问题的headerView

import UIKit

class HeHelpQuestionHeaderView: UITableViewHeaderFooterView {
    
    static let Id = "HeHelpQuestionHeaderView"
    
    let questionLabel = UILabel()
    let arrowImageView = UIImageView(image:UIImage(named: "cell_arrow_down_accessory"))
    let lineView = UIView()
    /// 点击header是的回调
    var selectedBlock:(()->())!
    
    var isSelected: Bool = false {
        willSet {
            if newValue {
                arrowImageView.image = UIImage(named: "cell_arrow_up_accessory")
            } else {
                arrowImageView.image = UIImage(named: "cell_arrow_down_accessory")
            }
        }
    }
    
    var question: HEQuestion? {
        didSet {
            questionLabel.text = question?.title
            isSelected = (question?.isSelected)!  //确保缓存headerView箭头方向正确
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.whiteColor()
        
        questionLabel.font = UIFont.systemFontOfSize(16)
        contentView.addSubview(questionLabel)
        
        contentView.addSubview(arrowImageView)
        
        lineView.alpha = 0.08
        lineView.backgroundColor = UIColor.blackColor()
        contentView.addSubview(lineView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(HeHelpQuestionHeaderView.tapAction))
        contentView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        questionLabel.frame = CGRectMake(20, 0, width-20-30, height)
        arrowImageView.frame = CGRectMake(width - 30, (height - arrowImageView.size.height) * 0.5, arrowImageView.size.width, arrowImageView.size.height)
        lineView.frame = CGRectMake(0, 0, width, 1)
    }
    
    func tapAction(){
        if selectedBlock != nil{
            selectedBlock()
        }
    }
}
