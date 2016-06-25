//
//  HEMineModifyAddress.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/17.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

enum HEEditAddressVCType{
    case Add
    case Edit
}

class HEEditAddressVC: HEBaseViewController {
    
    //view
    private var contactsTextField: UITextField!
    private var manBtn:UIButton!
    private var womanBtn:UIButton!
    private var phoneNumberTextField: UITextField!
    private var provinceTextField: UITextField!
    private var areaTextField: UITextField!
    private var adressTextField: UITextField!
    private var deleteBtn:UIButton!
    
    //数据
    var vcType:HEEditAddressVCType = .Add
    var address:HEAddress? //初始化需要修改的数据
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initData()
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("保存", titleColor: HETextBlackColor, target: self, action: #selector(HEEditAddressVC.saveAddress))
    }
    
    private func initData(){
        if vcType == .Add{
            navigationItem.title = "添加地址"
            address = HEAddress()
        }else{
            navigationItem.title = "修改地址"
            contactsTextField.text = address?.accept_name
            phoneNumberTextField.text = address?.telphone
            provinceTextField.text = address?.province_name
            areaTextField.text = address?.city_name
            adressTextField.text = address?.address
            manBtn.selected = (address?.isMan)!
            womanBtn.selected = !manBtn.selected
        }
    }
    
    private func initView(){
        view.backgroundColor = HEGlobalBackgroundColor
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.backgroundColor = UIColor.clearColor()
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        
        let addressView = UIView(frame: CGRectMake(0, 10, view.width, 300))
        addressView.backgroundColor = UIColor.whiteColor()
        scrollView.addSubview(addressView)
        
        let leftMargin:  CGFloat = 15
        let labelWidth:  CGFloat = 70
        let viewHeight: CGFloat = 50
        buildLabel(CGRectMake(leftMargin, 0, labelWidth, viewHeight), text: "联系人",inView: addressView)
        buildGenderBut(CGRectMake(leftMargin, 1 * viewHeight, labelWidth, viewHeight), inView: addressView)
        buildLabel(CGRectMake(leftMargin, 2 * viewHeight, labelWidth, viewHeight), text: "手机号码",inView: addressView)
        buildLabel(CGRectMake(leftMargin, 3 * viewHeight, labelWidth, viewHeight), text: "所在城市",inView: addressView)
        buildLabel(CGRectMake(leftMargin, 4 * viewHeight, labelWidth, viewHeight), text: "所在地区",inView: addressView)
        buildLabel(CGRectMake(leftMargin, 5 * viewHeight, labelWidth, viewHeight), text: "详细地址",inView: addressView)
        
        let textFieldX: CGFloat = leftMargin+labelWidth+leftMargin
        let textFieldWidth:CGFloat = addressView.width - textFieldX
        contactsTextField = buildTextField(CGRectMake(textFieldX, 0, textFieldWidth, viewHeight), placeholder: "收货人姓名", tag: 1, inView: addressView)
        phoneNumberTextField = buildTextField(CGRectMake(textFieldX, 2*viewHeight, textFieldWidth, viewHeight), placeholder: "鲜蜂侠联系你的电话", tag: 1, inView: addressView)
        provinceTextField = buildTextField(CGRectMake(textFieldX, 3*viewHeight, textFieldWidth, viewHeight), placeholder: "请选择城市", tag: 1, inView: addressView)
        areaTextField = buildTextField(CGRectMake(textFieldX, 4*viewHeight, textFieldWidth, viewHeight), placeholder: "请选择你的住宅，大厦或学校", tag: 1, inView: addressView)
        adressTextField = buildTextField(CGRectMake(textFieldX, 5*viewHeight, textFieldWidth, viewHeight), placeholder: "请输入楼号门牌号等详细信息", tag: 1, inView: addressView)
    
        deleteBtn = UIButton(frame: CGRectMake(0, CGRectGetMaxY(addressView.frame) + 10, view.width, 50))
        deleteBtn.setTitle("删除地址", forState: .Normal)
        deleteBtn.setTitleColor(HETextBlackColor, forState: .Normal)
        deleteBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        deleteBtn.backgroundColor = UIColor.whiteColor()
        deleteBtn.addTarget(self, action: #selector(HEEditAddressVC.deleteAddress(_:)), forControlEvents: .TouchUpInside)
        scrollView.addSubview(deleteBtn)
    }
    
    private func buildLabel(frame: CGRect, text: String,inView:UIView){
        let label = UILabel(frame: frame)
        label.height-=1
        label.text = text
        label.font = UIFont.systemFontOfSize(14)
        label.textColor = HETextBlackColor
        inView.addSubview(label)
        //分割线
        let lineView = UIView(frame: CGRectMake(15, CGRectGetMaxY(label.frame), view.width - 10, 1))
        lineView.alpha = 0.15
        lineView.backgroundColor = UIColor.lightGrayColor()
        inView.addSubview(lineView)
    }
    
    private func buildTextField(frame: CGRect, placeholder: String, tag: Int,inView:UIView)->UITextField {
        let textField = UITextField(frame: frame)
        textField.height-=1
        if 2 == tag {
            textField.keyboardType = UIKeyboardType.NumberPad
        }
        if 3 == tag {
//            selectCityPickView = UIPickerView()
//            selectCityPickView!.delegate = self
//            selectCityPickView!.dataSource = self
//            textField.inputView = selectCityPickView
//            textField.inputAccessoryView = buildInputView()
        }
        
        textField.tag = tag
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.autocapitalizationType = UITextAutocapitalizationType.None
        textField.placeholder = placeholder
        textField.font = UIFont.systemFontOfSize(14)
        //textField.delegate = self
        textField.textColor = HETextBlackColor
        inView.addSubview(textField)
        return textField
    }
    
    private func buildGenderBut(frame: CGRect,inView:UIView){
        manBtn = LeftImageRightTextButton(frame:CGRectMake(inView.width-200-20,frame.origin.y,100,49))
        manBtn.setTitle("先生", forState: .Normal)
        manBtn.setImage(UIImage(named: "v2_noselected"), forState: UIControlState.Normal)
        manBtn.setImage(UIImage(named: "v2_selected"), forState: UIControlState.Selected)
        manBtn.addTarget(self, action: #selector(HEEditAddressVC.selectGender(_:)), forControlEvents: .TouchUpInside)
        manBtn.selected = true
        inView.addSubview(manBtn)
        
        womanBtn = LeftImageRightTextButton(frame:CGRectMake(CGRectGetMaxX(manBtn.frame)+10,frame.origin.y,100,49))
        womanBtn.setTitle("女士", forState: .Normal)
        womanBtn.setImage(UIImage(named: "v2_noselected"), forState: UIControlState.Normal)
        womanBtn.setImage(UIImage(named: "v2_selected"), forState: UIControlState.Selected)
        womanBtn.addTarget(self, action: #selector(HEEditAddressVC.selectGender(_:)), forControlEvents: .TouchUpInside)
        inView.addSubview(womanBtn)
        
        let lineView = UIView(frame: CGRectMake(15, CGRectGetMaxY(manBtn.frame), view.width - 10, 1))
        lineView.alpha = 0.15
        lineView.backgroundColor = UIColor.lightGrayColor()
        inView.addSubview(lineView)
    }
    
    @objc private func deleteAddress(sender:UIButton){
        HEUserInfo.shareUserInfo.addressData?.removeAddress(address!)
        navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func selectGender(sender:UIButton){
        if sender.selected {
            return
        }
        manBtn.selected = !manBtn.selected
        womanBtn.selected = !womanBtn.selected
    }
    
    /** 保存地址*/
    @objc private func saveAddress(){
        address?.accept_name = contactsTextField.text
        address?.telphone = phoneNumberTextField.text
        address?.province_name = provinceTextField.text
        address?.city_name = areaTextField.text
        address?.address = adressTextField.text
        address?.gender = manBtn.selected ?  "1":"0"
        if vcType == .Add{
            HEUserInfo.shareUserInfo.addressData?.addAddress(address!)
        }
        navigationController?.popViewControllerAnimated(true)
    }
}
