//
//  ADModel.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import Foundation

class ADModel: NSObject{
    var code = -1
    var msg: String?
    var data:AD?
    
    class func loadData(result:(data: ADModel!, error: NSError!)->Void) {
        
        if let path = NSBundle.mainBundle().pathForResource("AD", ofType: nil){
            ADModel.loadDataFromFile(path) { ( data,  e) -> Void in
                let adModel = data as? ADModel
                if adModel == nil {
                    result(data: nil, error: NSError(domain: "文件不存在", code: -1, userInfo: nil))
                    return
                }
                result(data: adModel, error: nil)
            }
        }
    
    }
}

class AD:NSObject {
    var title:String?
    var img_name:String?
    var img_big_name:String?
    var img_url:String?
    var starttime:String?
    var endtime:String?
}





