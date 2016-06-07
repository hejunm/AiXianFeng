//
//  HECommonCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/2.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommonCell: UITableViewCell {
    
    class func getCellForTableView(tableView:UITableView,itemModel:HECommenItem)->HECommonCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(itemModel.id) as? HECommonCell
        if cell == nil{
            //根据不同类型的HECommenItem， 返回对应的cell
            if itemModel.isMemberOfClass(HECommonItemArrow){
                cell = HECommonArrowCell(reuseIdentifier: itemModel.id)
            }else if itemModel.isMemberOfClass(HECommonItemOnlyLeftLabel){
                cell = HECommonOnlyLeftLabelCell(reuseIdentifier: itemModel.id)
            }else if itemModel.isMemberOfClass(HECommonItemSwitch){
                cell = HECommonSwitchCell(reuseIdentifier: itemModel.id)
            }else if itemModel.isMemberOfClass(HECommonItemThreeLabel){
                cell = HECommonThreeLabelCell(reuseIdentifier: itemModel.id)
            }else if itemModel.isMemberOfClass(HECommonItemOnlyRightLabel){
                cell = HECommonOnlyRightLabelCell(reuseIdentifier: itemModel.id)
            }else if itemModel.isMemberOfClass(HECommonItemDetailsCharges){
                cell = HECommonDetailsChargesCell(reuseIdentifier: itemModel.id)
            }else{
                cell = HECommonCell(reuseIdentifier: itemModel.id)
            }
        }
        cell?.itemModel = itemModel
        return cell!
    }
    
    init(reuseIdentifier: String?) {
        super.init(style: .Value1, reuseIdentifier: reuseIdentifier)
        
        textLabel?.textColor = UIColor.blackColor()
        textLabel?.font = UIFont.systemFontOfSize(14)
        
        detailTextLabel?.textColor = UIColor.blackColor()
        detailTextLabel?.font = UIFont.systemFontOfSize(14)
        selectionStyle = .None
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var itemModel:HECommenItem!{
        didSet{
            if let iconName = itemModel.iconName{
               imageView?.image = UIImage(named: iconName)
            }
            if let title = itemModel.title{
               textLabel?.text = title
            }
            if let subTitle = itemModel.subTitle{
                detailTextLabel?.text = subTitle
            }
            
            if let titleColor = itemModel.titleColor{
                textLabel?.textColor = titleColor
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRectMake(HEMargin_10, (height-20)/2, 20, 20)
        imageView?.contentMode = .ScaleAspectFit
    }
}



