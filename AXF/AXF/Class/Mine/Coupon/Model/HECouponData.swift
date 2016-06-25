//
//  HECouponData.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/14.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECouponData: NSObject {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Coupon]?
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "Coupon"]
    }
    
    class func loadData(result:(data: HECouponData!, error: NSError!)->Void) {
        if let path = NSBundle.mainBundle().pathForResource("MyCoupon", ofType: nil){
            HECouponData.loadDataFromFile(path) { (data,  e) -> Void in
                let model = data as? HECouponData
                if  model == nil {
                    result(data: nil, error: NSError(domain: "文件不存在", code: -1, userInfo: nil))
                    print("文件不存在")
                    return
                }
                result(data: model, error: nil)
            }
        }
    }
}

class Coupon: NSObject {
    var id: String?
    var card_pwd: String?
    /// 开始时间
    var start_time: String?
    /// 结束时间
    var end_time: String?
    /// 金额
    var value: String?
    var tid: String?
    /// 是否被使用 0 使用 1 未使用
    var is_userd: String?
    /// 0 可使用 1 不可使用
    var status: Int = -1
    var true_end_time: String?
    /// 标题
    var name: String?
    var point: String?
    var type: String?
    var order_limit_money: String?
    var desc: String?
    var free_freight: String?
    var city: String?
    var ctime: String?
}
