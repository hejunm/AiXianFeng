//
//  HEReceiptAddressView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  收货地址

import UIKit

class HEHeaderReceiptAddressView: UIView {
    
    private let topImageView = UIImageView(image: UIImage(named: "v2_shoprail"))
    private let bottomImageView = UIImageView(image: UIImage(named: "v2_shoprail"))
    private let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
    
    private let consigneeLabel = UILabel()
    private let phoneNumLabel = UILabel()
    private let receiptAdressLabel = UILabel()
    private let consigneeTextLabel = UILabel()
    private let phoneNumTextLabel = UILabel()
    private let receiptAdressTextLabel = UILabel()
    
    private let modifyButton = UIButton()
    var modifyButtonClickCallBack: (() -> ())?
    
    var address:HEAddress?{
        didSet{
            if address == nil {return}
            consigneeTextLabel.text = address?.accept_name
            phoneNumTextLabel.text = address?.telphone
            receiptAdressTextLabel.text = address?.address
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        addSubview(topImageView)
        addSubview(bottomImageView)
        addSubview(arrowImageView)
        
        modifyButton.setTitle("修改", forState: .Normal)
        modifyButton.setTitleColor(UIColor.redColor(), forState: .Normal)
        modifyButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        modifyButton.addTarget(self, action: #selector(HEHeaderReceiptAddressView.modifyBtnClick), forControlEvents: .TouchUpInside)
        addSubview(modifyButton)
        
        initLabel(consigneeLabel, text:"收货人")
        initLabel(consigneeTextLabel, text:"")
        initLabel(phoneNumLabel, text:"电话")
        initLabel(phoneNumTextLabel, text:"")
        initLabel(receiptAdressLabel, text:"收货地址")
        initLabel(receiptAdressTextLabel, text:"")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect,modiftBtnClick:()->()) {
        self.init(frame: frame)
        modifyButtonClickCallBack = modiftBtnClick
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let leftMargin: CGFloat = 15
        let firstLabelWidth: CGFloat = 70
        let secondLabelWidth: CGFloat = width-leftMargin-firstLabelWidth-5-60
        
        topImageView.frame = CGRectMake(0, 0, width, 2)
        bottomImageView.frame = CGRectMake(0, height - 2, width, 2)
        arrowImageView.frame = CGRectMake(width - 15, (height - arrowImageView.height) * 0.5, arrowImageView.width, arrowImageView.height)
        
        consigneeLabel.frame = CGRectMake(leftMargin, 10, firstLabelWidth, consigneeLabel.height)
        consigneeTextLabel.frame = CGRectMake(CGRectGetMaxX(consigneeLabel.frame) + 5, consigneeLabel.y, secondLabelWidth, consigneeLabel.height)
        
        phoneNumLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(consigneeLabel.frame) + 5, firstLabelWidth, phoneNumLabel.height)
        phoneNumTextLabel.frame = CGRectMake(consigneeTextLabel.x, phoneNumLabel.y, secondLabelWidth, phoneNumLabel.height)
        
        receiptAdressLabel.frame = CGRectMake(leftMargin, CGRectGetMaxY(phoneNumTextLabel.frame) + 5, firstLabelWidth, receiptAdressLabel.height)
        receiptAdressTextLabel.frame = CGRectMake(consigneeTextLabel.x, receiptAdressLabel.y, secondLabelWidth, receiptAdressLabel.height)
        
        modifyButton.frame = CGRectMake(width - 60, 0, 30, height)
    }
    
    func modifyBtnClick(){
        if modifyButtonClickCallBack != nil{
            modifyButtonClickCallBack!()
        }
    }
    
    private func initLabel(label:UILabel,text:String){
        label.text = text
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor.blackColor()
        label.sizeToFit()
        addSubview(label)
    }
    
}
