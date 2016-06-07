//
//  HECommonSwitchCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/4.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonSwitchCell: HECommonCell{
    let switchButton:UIButton = {
        let switchButton = UIButton()
        switchButton.setImage(UIImage(named: "v2_noselected"), forState: UIControlState.Normal)
        switchButton.setImage(UIImage(named: "v2_selected"), forState: UIControlState.Selected)
        switchButton.userInteractionEnabled = false
        switchButton.size = CGSizeMake(16, 16)
        return switchButton
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        accessoryView = switchButton
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override var itemModel: HECommenItem!{
        didSet{
            if let item = itemModel as? HECommonItemSwitch{
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HECommonSwitchCell.setSwicth(_:)), name: HENotiCheckBoxGroupSelectChanged, object: item.group)
                
                if item.isSelected == true{
                    NSNotificationCenter.defaultCenter().postNotificationName(HENotiCheckBoxGroupSelectChanged, object: item.group, userInfo: ["itemModel":item])
                }
            }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func setSwicth(noti:NSNotification){
        if let item = noti.userInfo!["itemModel"] as? HECommonItemSwitch{
            if item == itemModel{
                item.isSelected = true
                switchButton.selected = true
            }else{
                item.isSelected = false
                switchButton.selected = false
            }
        }
    }
}


