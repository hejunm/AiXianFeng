//
//  HETableView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HETableView: UITableView {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame:frame,style:style);
        separatorStyle = .None
        delaysContentTouches = false
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancelInContentView(view: UIView) -> Bool {
        if view.isKindOfClass(UIControl){ //默认返回false
            return true
        }
        return super.touchesShouldCancelInContentView(view)
    }
}
