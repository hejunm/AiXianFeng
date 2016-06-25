//
//  HEAddressCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/16.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEAddressCell: UITableViewCell {
    
    static let Id = "HEAddressCell"
    class func getCell(tableView: UITableView,modifyBtnClick:((address:HEAddress)->())) -> HEAddressCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Id) as? HEAddressCell
        if cell == nil {
            cell = HEAddressCell(style: UITableViewCellStyle.Default, reuseIdentifier: Id)
        }
        cell?.modifyBtnClick = modifyBtnClick
        return cell!
    }
    
    var address:HEAddress?{
        didSet{
            nameLabel.text   = address!.accept_name
            phoneLabel.text  = address!.telphone
            adressLabel.text = address!.address
        }
    }
    
    private let nameLabel       = UILabel()
    private let phoneLabel      = UILabel()
    private let adressLabel     = UILabel()
    private let lineView        = UIView()
    private let modifyBtn       = UIButton()
    private let bottomView      = UIView()
    private var modifyBtnClick:((address:HEAddress)->())?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .None
        
        nameLabel.font = UIFont.systemFontOfSize(14)
        nameLabel.textColor = HETextBlackColor
        contentView.addSubview(nameLabel)
        
        phoneLabel.font = UIFont.systemFontOfSize(14)
        phoneLabel.textColor = HETextBlackColor
        contentView.addSubview(phoneLabel)
        
        adressLabel.font = UIFont.systemFontOfSize(13)
        adressLabel.textColor = UIColor.lightGrayColor()
        contentView.addSubview(adressLabel)
        
        lineView.backgroundColor = UIColor.lightGrayColor()
        lineView.alpha = 0.2
        contentView.addSubview(lineView)
        
        modifyBtn.setImage(UIImage(named: "v2_address_edit_highlighted"), forState: .Normal)
        modifyBtn.contentMode = UIViewContentMode.Center
        modifyBtn.addTarget(self, action: #selector(HEAddressCell.modifyBtnClickAction(_:)), forControlEvents: .TouchUpInside)
        contentView.addSubview(modifyBtn)
        
        bottomView.backgroundColor = UIColor.lightGrayColor()
        bottomView.alpha = 0.4
        contentView.addSubview(bottomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRectMake(10, 15, 80, 20)
        phoneLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) + 10, 15, 150, 20)
        adressLabel.frame = CGRectMake(10, CGRectGetMaxY(phoneLabel.frame) + 10, width * 0.6, 20)
        lineView.frame = CGRectMake(width * 0.8, 10, 1, height - 20)
        modifyBtn.frame = CGRectMake(width * 0.8 + (width * 0.2 - 40) * 0.5, (height - 40) * 0.5, 40, 40)
        bottomView.frame = CGRectMake(0, height - 1, width, 1)
    }
    
    @objc private func modifyBtnClickAction(sender:UIButton){
        if modifyBtnClick != nil{
            modifyBtnClick!(address: address!)
        }
    }
}
