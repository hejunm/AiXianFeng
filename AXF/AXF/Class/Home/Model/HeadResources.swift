//
//  HeadResources.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/4.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import Foundation

class HeadResources: NSObject {
    var msg: String?
    var reqid: String?
    var data: HeadData?
    
    class func loadData(result:(data: HeadResources!, error: NSError!)->Void) {
        if let path = NSBundle.mainBundle().pathForResource("首页焦点按钮", ofType: nil){
            HeadResources.loadDataFromFile(path) { ( data,  e) -> Void in
                let model = data as? HeadResources
                if  model == nil {
                    result(data: nil, error: NSError(domain: "文件不存在", code: -1, userInfo: nil))
                    return
                }
                result(data: model, error: nil)
            }
        }
    }
}

class HeadData: NSObject, DictModelProtocol {
    var focus: [Activitie]?         //最上面的的轮播图
    var icons: [Activitie]?         //icon
    var activities: [Activitie]?    //活动
    
    static func customClassMapping() -> [String: String]?{
        return ["focus":"Activitie","icons":"Activitie","activities":"Activitie"]
    }
}


class Activitie: NSObject {
    var id: String?
    var name: String?
    var img: String?
    var topimg: String?
    var jptype: String?
    var trackid: String?
    var mimg: String?
    var customURL: String?
}