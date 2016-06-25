//
//  HEMineOrderStatusCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/11.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

enum OrderStateType {
    case Top
    case Middle
    case Bottom
}

class HEMineOrderStatusCell: UITableViewCell {
    
    private static let Id = "orderStatusCell"
    class func orderStatusCell(tableView: UITableView) -> HEMineOrderStatusCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Id) as? HEMineOrderStatusCell
        if cell == nil {
            cell = HEMineOrderStatusCell(style: UITableViewCellStyle.Default, reuseIdentifier: Id)
        }
        return cell!
    }
    
    private var timeLabel: UILabel!
    private var titleLabel: UILabel!
    private var subTitleLable: UILabel!
    private var circleButton: UIButton!
    private var topLineView: UIView!
    private var bottomLineView: UIView!
    private var lineView: UIView!
    
    var orderStatus:OrderStatus!{
        didSet{
            if orderStatus == nil{return}
            timeLabel.text = orderStatus.status_time
            titleLabel.text = orderStatus.status_title
            subTitleLable.text = orderStatus.status_desc
            
            
            let tmpStr = orderStatus.status_desc! as NSString
            if tmpStr.length > 10{
                let str = tmpStr.substringToIndex(5) as NSString
                if str.isEqualToString("下单成功，") {
                    let mutableStr = NSMutableString(string: tmpStr)
                    mutableStr.insertString("\n ", atIndex: 9)
                    subTitleLable?.text = mutableStr as String
                }
            }
        }
    }
    
    var orderStateType:OrderStateType!{
        didSet{
            if orderStateType == nil {return}
            switch orderStateType!{
            case .Top:
                circleButton.selected = true
                topLineView.hidden = true
                bottomLineView.hidden = false
                lineView.hidden = false
                subTitleLable.numberOfLines = 1
            case .Middle:
                circleButton.selected = false
                topLineView.hidden = false
                bottomLineView.hidden = false
                lineView.hidden = false
                subTitleLable.numberOfLines = 1
            case .Bottom:
                circleButton.selected = false
                topLineView.hidden = false
                bottomLineView.hidden = true
                lineView.hidden = true
                subTitleLable.numberOfLines = 0
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.None
        
        let textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        
        timeLabel = UILabel()
        timeLabel.textColor = textColor
        timeLabel.textAlignment = NSTextAlignment.Center
        timeLabel.font = UIFont.systemFontOfSize(12)
        contentView.addSubview(timeLabel!)
        
        circleButton = UIButton()
        circleButton.userInteractionEnabled = false
        circleButton.setBackgroundImage(UIImage(named: "order_grayMark"), forState: UIControlState.Normal)
        circleButton.setBackgroundImage(UIImage(named: "order_yellowMark"), forState: UIControlState.Selected)
        contentView.addSubview(circleButton!)
        
        topLineView = UIView()
        topLineView.backgroundColor = textColor
        topLineView.alpha = 0.3
        contentView.addSubview(topLineView!)
        
        bottomLineView = UIView()
        bottomLineView.backgroundColor = textColor
        bottomLineView.alpha = 0.3
        contentView.addSubview(bottomLineView!)
        
        titleLabel = UILabel()
        titleLabel.textColor = textColor
        titleLabel.font = UIFont.systemFontOfSize(15)
        contentView.addSubview(titleLabel!)
        
        subTitleLable = UILabel()
        subTitleLable.textColor = textColor
        subTitleLable.font = UIFont.systemFontOfSize(12)
        contentView.addSubview(subTitleLable!)
        
        lineView = UIView()
        lineView.backgroundColor = textColor
        lineView.alpha = 0.2
        contentView.addSubview(lineView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let margin: CGFloat = 15
        timeLabel?.frame = CGRectMake(margin, 12, 35, 20)
        circleButton?.frame = CGRectMake(CGRectGetMaxX(timeLabel!.frame) + 10, 15, 15, 15)
        topLineView?.frame = CGRectMake((circleButton?.center.x)! - 1, 0, 2, 15 )
        bottomLineView?.frame = CGRectMake((circleButton?.center.x)! - 1, 15 + 15, 2, height - 15 - 15)
        titleLabel?.frame = CGRectMake(CGRectGetMaxX(circleButton!.frame) + 20, 12, width - CGRectGetMaxX(circleButton!.frame) - 20, 20)
        subTitleLable?.frame = CGRectMake(titleLabel!.x, CGRectGetMaxY(titleLabel!.frame) + 10, width - titleLabel!.frame.origin.x, 30)
        lineView?.frame = CGRectMake(titleLabel!.x, height - 1, width - titleLabel!.x, 1)
    }
}
