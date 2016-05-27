//
//  HESuperMarket.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/26.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import Foundation

class HESuperMarket: NSObject {
    var code:Int = -1
    var msg: String?
    var reqid: String?
    var data: SupermarketResouce?
    
    class func loadData(result:(data: HESuperMarket!, error: NSError!)->Void) {
        if let path = NSBundle.mainBundle().pathForResource("supermarket", ofType: nil){
            HESuperMarket.loadDataFromFile(path) { ( data,  e) -> Void in
                let model = data as? HESuperMarket
                if  model == nil {
                    result(data: nil, error: NSError(domain: "文件不存在", code: -1, userInfo: nil))
                    return
                }
                result(data: model, error: nil)
            }
        }
    }

    /**
     - returns: categories or nil
     */
    func getCategories()->[Categorie]!{
        return data?.categories
    }
    
    /**
     获取指定下标的category 对应的[Goods]
     
     - parameter index: category在数组中的下标
     
     - returns:[Goods] or nil
     */
    func getGoodsArrayForCategoryAt(index index:Int)->[Goods]!{
        let categorie = getCategories()[index]
        return data?.products?.valueForKey(categorie.id!) as? [Goods]
    }
}

class SupermarketResouce: NSObject,DictModelProtocol{
    var categories:[Categorie]?
    var products:Product?
    var trackid:String?
    static func customClassMapping() -> [String: String]?{
        return ["categories":"Categorie"]
    }
}

class Categorie:NSObject{
    var id:String?
    var name:String?
    var icon:String?
    var sort:String?
    var visibility:String?
    var pcid:String?
    var disabled_show:Int?
}

class Product: NSObject,DictModelProtocol{
    var a82: [Goods]?
    var a96: [Goods]?
    var a99: [Goods]?
    var a106: [Goods]?
    var a134: [Goods]?
    var a135: [Goods]?
    var a136: [Goods]?
    var a137: [Goods]?
    var a141: [Goods]?
    var a143: [Goods]?
    var a147: [Goods]?
    var a151: [Goods]?
    var a152: [Goods]?
    var a158: [Goods]?
    
    static func customClassMapping() -> [String: String]?{
        return ["a82":"Goods",
            "a96":"Goods",
            "a99":"Goods",
            "a106":"Goods",
            "a134":"Goods",
            "a135":"Goods",
            "a136":"Goods",
            "a137":"Goods",
            "a141":"Goods",
            "a143":"Goods",
            "a147":"Goods",
            "a151":"Goods",
            "a152":"Goods",
            "a158":"Goods",
        ]
    }
}


