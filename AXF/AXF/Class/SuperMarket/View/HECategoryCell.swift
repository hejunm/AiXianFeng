//
//  HECategoryCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECategoryCell: UITableViewCell {
   
    static let categoryCellId = "categoryCellId"
    
    //MARK: property
    private lazy var backGroundImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "llll")
        imageView.highlightedImage = UIImage(named: "kkkkkkk")
        return imageView
    }()
    
    private lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = HETextGreyColol
        nameLabel.highlightedTextColor = HETextBlackColor
        nameLabel.backgroundColor = UIColor.clearColor()
        nameLabel.textAlignment = NSTextAlignment.Center
        nameLabel.font = UIFont.systemFontOfSize(14)
        return nameLabel
    }()
    
    private lazy var yellowView:UIView = {
        let yellowView = UIView()
        yellowView.backgroundColor = UIColor.yellowColor()
        return yellowView
    }()
    
    private lazy var lineView:UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.colorWithCustom(225, g: 225, b: 225)
        return lineView
    }()
    
    var categorie:Categorie!{
        didSet{
            if categorie != nil{
                nameLabel.text = categorie.name
            }
        }
    }
    
    //MARK: init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = UITableViewCellSelectionStyle.None
        contentView.addSubview(backGroundImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(yellowView)
        contentView.addSubview(lineView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getCellFor(tableView tableView:UITableView)->HECategoryCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(categoryCellId) as? HECategoryCell
        if cell == nil{
            cell = HECategoryCell(style:.Default , reuseIdentifier: categoryCellId)
        }
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundImageView.frame = bounds
        nameLabel.frame = bounds
        yellowView.frame = CGRectMake(0, height * 0.1, 5, height * 0.8)
        lineView.frame = CGRectMake(0, height - 1, width, 1)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backGroundImageView.highlighted = selected
        nameLabel.highlighted = selected
        yellowView.hidden = !selected
    }
}
