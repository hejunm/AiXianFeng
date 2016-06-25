//
//  HEMineHeaderView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/6.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit


class HEMineVC_HeaderView: UIImageView {
    static let mineHeaderViewH:CGFloat = 150
    
    var iconView:HEIconView!
    var settingBtn:UIButton!
    var settingBtnClick:(()->())!
    
    init(frame: CGRect,btnClick:(()->())!) {
        super.init(frame: frame)
        userInteractionEnabled = true
        image = UIImage(named: "v2_my_avatar_bg")
        
        iconView = HEIconView()
        addSubview(iconView)
        
        settingBtn = UIButton()
        settingBtn.setImage(UIImage(named: "v2_my_settings_icon"), forState: .Normal)
        settingBtn.addTarget(self, action: #selector(HEMineVC_HeaderView.btnClickAction(_:)), forControlEvents: .TouchUpInside)
        addSubview(settingBtn)
        
        self.settingBtnClick = btnClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconViewWH: CGFloat = HEMineVC_HeaderView.mineHeaderViewH
        iconView.frame = CGRectMake((width - iconViewWH) * 0.5, 0, iconViewWH, iconViewWH)
        settingBtn.frame = CGRectMake(width - 50, 10, 50, 50)
    }
    
    //MARK: action
    func btnClickAction(sender:UIButton){
        if settingBtnClick != nil{
            settingBtnClick()
        }
    }
}

class HEIconView: UIView {
    var iconImageView: UIImageView!
    var phoneNum: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView = UIImageView(image: UIImage(named: "v2_my_avatar"))
        addSubview(iconImageView)
        
        phoneNum = UILabel()
        phoneNum.text = "1143024986"
        phoneNum.font = UIFont.boldSystemFontOfSize(18)
        phoneNum.textColor = UIColor.whiteColor()
        phoneNum.textAlignment = .Center
        addSubview(phoneNum)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRectMake((width - iconImageView.size.width) * 0.5, 30, iconImageView.size.width, iconImageView.size.height)
        phoneNum.frame = CGRectMake(0, CGRectGetMaxY(iconImageView.frame) + 5, width, 30)
    }

}
