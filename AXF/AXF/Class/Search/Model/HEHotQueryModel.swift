//
//  HESearchHotProduce.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  热门搜索

import UIKit

class HEHotQueryModel: NSObject {

    var code:Int = -1
    var msg:String?
    var reqid:String?
    var data:HEHotQureyData?
    
    class func loadData(result:(data: HEHotQueryModel!, error: NSError!)->Void) {
        if let path = NSBundle.mainBundle().pathForResource("SearchProduct", ofType: nil){
            HEHotQueryModel.loadDataFromFile(path) { ( data,  e) -> Void in
                let model = data as? HEHotQueryModel
                if  model == nil {
                    result(data: nil, error: NSError(domain: "文件不存在或解析错误", code: -1, userInfo: nil))
                    return
                }
                result(data: model, error: nil)
            }
        }else{
            print("文件不存在")
        }
    }
}

class HEHotQureyData:NSObject{
    var hotquery:[String]?
}
