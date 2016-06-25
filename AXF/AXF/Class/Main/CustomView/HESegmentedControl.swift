//
//  HESegmentedControl.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/11.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESegmentedControl: UISegmentedControl {
   
    var segmentedClick:((index: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(items: [AnyObject]?) {
        super.init(items: items)
        tintColor = HENavigationYellowColor
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()], forState: UIControlState.Selected)
        setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.colorWithCustom(100, g: 100, b: 100)], forState: UIControlState.Normal)
        addTarget(self, action: #selector(HESegmentedControl.segmentedControlDidValuechange(_:)), forControlEvents: UIControlEvents.ValueChanged)
        selectedSegmentIndex = 0
    }
    
    convenience init(items: [AnyObject]?,segmentedClick:((index: Int) -> Void)?) {
        self.init(items:items)
        self.segmentedClick = segmentedClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func segmentedControlDidValuechange(sender:HESegmentedControl){
        if segmentedClick != nil {
            segmentedClick!(index: sender.selectedSegmentIndex)
        }
    }
}
