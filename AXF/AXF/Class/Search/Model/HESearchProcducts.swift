//
//  HESearchProcducts.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESearchProcducts: NSObject,DictModelProtocol {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Goods]?
    
    static func customClassMapping() -> [String: String]?{
        return ["data":"Goods"]
    }
    
    class func loadData(result:(data: HESearchProcducts!, error: NSError!)->Void) {
        if let path = NSBundle.mainBundle().pathForResource("促销", ofType: nil){
            HESearchProcducts.loadDataFromFile(path) { ( data,  e) -> Void in
                let model = data as? HESearchProcducts
                if  model == nil {
                    result(data: nil, error: NSError(domain: "文件不存在", code: -1, userInfo: nil))
                    return
                }
                result(data: model, error: nil)
            }
        }
    }
}
