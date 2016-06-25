//
//  HEMessage.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/14.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

enum UserMessageType {
    case System
    case User
}
class HEMessageData:NSObject,DictModelProtocol{
    var code:Int = -1
    var msg:String?
    var reqid:String?
    var data:[HEMessage]?
    
    class func loadData(type:UserMessageType, result:(data: HEMessageData!, error: NSError!)->Void) {
        var fileName:String!
        if type == .System {
            fileName = "SystemMessage"
        }else{
            fileName = "UserMessage"
        }
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil){
            HEMessageData.loadDataFromFile(path) { ( data,  e) -> Void in
                let model = data as? HEMessageData
                if  model == nil {
                    result(data: nil, error: NSError(domain: "文件不存在", code: -1, userInfo: nil))
                    print("文件不存在")
                    return
                }
                result(data: model, error: nil)
            }
        }
    }
    
    static func customClassMapping() -> [String: String]?{
        return ["data":"HEMessage"]
    }
}

class HEMessage: NSObject {
    var id: String?
    var type = -1
    var title: String?
    var content: String?
    var link: String?
    var city: String?
    var noticy: String?
    var send_time: String?
    var content_type: String?
    
    var isSelected = false
    let normalCellHeight: CGFloat = 60 + 60 + 20
    ///高度组成 titleView:60, subTitleView: 10+contentH+10, 20的间隔。 期中contentH默认40
    lazy var selectedCellHeight:CGFloat = {
        if let contentStr = self.content{
            let contentH = contentStr.getAttStr().boundingRectWithSize(CGSizeMake(ScreenWidth-40, CGFloat.max), options: .UsesLineFragmentOrigin, context: nil).height
            return 60+10+contentH+10+20
        }
        return self.normalCellHeight
    }()
}
extension String{
    func getAttStr() -> NSAttributedString{
        let attStr = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.0
        //NSFontAttributeName UIFont, default Helvetica(Neue) 12
        attStr.addAttributes([NSParagraphStyleAttributeName : paragraphStyle], range: NSMakeRange(0, attStr.length))
        return attStr
    }
}
