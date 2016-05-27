//
//  FreshHot.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import Foundation

class FreshHot: NSObject,DictModelProtocol{
    var page: Int = -1
    var code: Int = -1
    var msg: String?
    var data: [Goods]?
    static func customClassMapping() -> [String: String]?{
        return ["data":"Goods"]
    }
    
    class func loadData(result:(data: FreshHot!, error: NSError!)->Void) {
        if let path = NSBundle.mainBundle().pathForResource("首页新鲜热卖", ofType: nil){
            FreshHot.loadDataFromFile(path) { ( data,  e) -> Void in
                let model = data as? FreshHot
                if  model == nil {
                    result(data: nil, error: NSError(domain: "文件不存在或解析错误", code: -1, userInfo: nil))
                    return
                }
                result(data: model, error: nil)
            }
        }
    }
}

class Goods: NSObject {
    //*************************商品模型默认属性**********************************
    /// 商品ID
    var id: String?
    /// 商品姓名
    var name: String?
    var brand_id: String?
    /// 超市价格
    var market_price: String?
    var cid: String?
    var category_id: String?
    /// 当前价格
    var partner_price: String?
    var brand_name: String?
    var pre_img: String?
    
    var pre_imgs: String?
    /// 参数
    var specifics: String?
    var product_id: String?
    var dealer_id: String?
    /// 当前价格
    var price: String?
    /// 库存
    var number: Int = -1
    /// 是否有活动， 活动描述
    var pm_desc: String?
    var had_pm: Int = -1
    /// urlStr
    var img: String?
    /// 是不是精选 0 : 不是, 1 : 是
    var is_xf: Int = 0
    
    //*************************商品模型辅助属性**********************************
    // 这样记录购买数量是有bug的。 比如刷新界面，购买数量信息就没有了。我的想法是用数据库，这里就不涉及了。
    // 记录用户对商品添加次数
    var userBuyNumber: Int = 0
}
