//
//  UserInfo.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  用户信息

import Foundation

class HEUserInfo: NSObject {
   //MARK: 获取单例
    static private let instance = HEUserInfo()
    static var shareUserInfo:HEUserInfo{
        return instance
    }
    
    //MARK: property
    var addressData:HEAddressData?
    
    private override init() {
        super.init()
        weak var tmpSelf = self
        HEAddressData.loadData { (data, error) in
            tmpSelf!.addressData = data
        }
    }
}
