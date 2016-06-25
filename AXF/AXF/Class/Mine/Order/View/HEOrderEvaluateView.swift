//
//  HEOrderEvaluateView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/12.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  评价

import UIKit

class HEOrderEvaluateView: UIView {
    
    private let myEvaluateLabel = UILabel()
    private let evaluateLabel = UILabel()
    private lazy var starImageViews: [UIImageView] = {
        var starImageViews: [UIImageView] = []
        for i in 0...4 {
            let starImageView = UIImageView(image: UIImage(named: "v2_star_no"))
            starImageViews.append(starImageView)
        }
        return starImageViews
    }()
    
    var order: Order? {
        didSet {
            evaluateLabel.text = order?.comment
            if order?.star != nil{
                for i in 0..<order!.star {
                    let starImageView = starImageViews[i]
                    starImageView.image = UIImage(named: "v2_star_on")
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = UIColor.whiteColor()
        
        myEvaluateLabel.text = "我的评价"
        myEvaluateLabel.textColor = HETextBlackColor
        myEvaluateLabel.font = UIFont.systemFontOfSize(14)
        myEvaluateLabel.frame = CGRectMake(10, 5, width-10, 25)
        addSubview(myEvaluateLabel)
        
        for i in 0...4 {
            let starImageView = starImageViews[i]
            starImageView.frame = CGRectMake(10 + CGFloat(i) * 30, CGRectGetMaxY(myEvaluateLabel.frame) + 5, 25, 25)
            addSubview(starImageView)
        }
        
        evaluateLabel.font = UIFont.systemFontOfSize(14)
        evaluateLabel.textColor = HETextBlackColor
        evaluateLabel.frame = CGRectMake(10, CGRectGetMaxY(starImageViews[0].frame) + 10, width - 20, 25)
        addSubview(evaluateLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
