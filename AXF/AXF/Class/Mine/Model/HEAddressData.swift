//
//  HEAddress.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  收货地址

import Foundation

class HEAddressData: NSObject,DictModelProtocol{
    var code:Int = -1
    var msg: String?
    var reqid: String?
    var data: [HEAddress]?
    
    static func customClassMapping() -> [String: String]?{
        return ["data":"HEAddress"]
    }
    
    static func loadData(result:(data: HEAddressData!, error: NSError!)->Void) {
        if let path = NSBundle.mainBundle().pathForResource("MyAddress", ofType: nil){
            HEAddressData.loadDataFromFile(path) { ( data,  e) -> Void in
                guard let model = data as? HEAddressData else{
                    result(data: nil, error: NSError(domain: "文件不存在", code: -1, userInfo: nil))
                    return
                }
                result(data: model, error: nil)
            }
        }
    }
    
    /** 获取全部收货地址*/
    func getAllAddress()->[HEAddress]?{
        return data
    }
    
    /** 获取默认收货地址*/
    func getDefaultAddress() -> HEAddress?{
        if data == nil{ return nil}
        for item in data!{
            if item.isDefault == 1{
                return item
            }
        }
        return nil
    }
    
    /**修改某收货地址为默认地址*/
    func setDefaultAddress(address:HEAddress){
        for item in data!{
            if item == address{
                item.isDefault = 1
            }else{
                item.isDefault = 0
            }
        }
    }
}

class HEAddress: NSObject {
    var accept_name: String?
    var telphone: String?
    var province_name: String?
    var city_name: String?
    var address: String?
    var lng: String?
    var lat: String?
    var gender: String?
    var isDefault:Int = 0
}