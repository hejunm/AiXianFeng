//
//  HEHelpAnswerCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/16.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEHelpAnswerCell: UITableViewCell {
    
    static private let Id = "HEHelpAnswerCell"
    class func getCell(tableView: UITableView,question:HEQuestion) -> HEHelpAnswerCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Id) as? HEHelpAnswerCell
        if cell == nil {
            cell = HEHelpAnswerCell(style: UITableViewCellStyle.Default, reuseIdentifier: Id)
        }
        cell?.question = question
        return cell!
    }
    
    //MARK: property
    
    var question:HEQuestion!{
        didSet{
            for  subView in contentView.subviews{
                subView.removeFromSuperview()
            }
            if question.texts == nil {return}
            var textY:CGFloat = 0
            for i in 0..<question.texts!.count{
                let label = UILabel()
                label.numberOfLines = 0
                label.textAlignment = NSTextAlignment.Left
                label.backgroundColor = UIColor.clearColor()
                label.textColor = UIColor.lightGrayColor()
                label.font = UIFont.systemFontOfSize(14)
                
                let arrStr = question.texts![i].getAttStr()
                label.attributedText = arrStr
                label.frame = CGRectMake(20, textY, ScreenWidth-20*2, question.everyRowHeight[i])
                textY += question.everyRowHeight[i]
                contentView.addSubview(label)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
