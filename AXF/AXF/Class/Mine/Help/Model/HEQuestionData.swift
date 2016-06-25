//
//  HEQuestionData.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/15.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEQuestion: NSObject {
    var title: String?
    var texts: [String]?{
        didSet{
            if let textArray = texts{
                for text in textArray{
                    let textH = text.boundingRectWithSize(CGSizeMake(ScreenWidth-20*2, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)], context: nil).size.height + 14
                    everyRowHeight.append(textH)
                    cellHeight+=textH
                }
                cellHeight+=10
            }
        }
    }
   
    /// 是否选中了某一个问题. 保证了即使headerView缓存了也能显示出箭头正确的状态
    var isSelected:Bool = false
    /// 每一个text对应的height
    var everyRowHeight: [CGFloat] = []
    
    /// 答案cell 对应高度. 上下边距为10
    var cellHeight:CGFloat = 0
    
    class func loadData(result:(data: [HEQuestion]!, error: NSError!)->Void) {
        guard let path = NSBundle.mainBundle().pathForResource("HelpPlist.plist", ofType: nil)else{
            result(data: nil, error: NSError(domain: "path error", code: -1, userInfo: nil))
            return
        }
        guard let array = NSArray(contentsOfFile: path)else{
            result(data: nil, error: NSError(domain: "error when plist->array ", code: -1, userInfo: nil))
            return
        }
        if let modelArray = HEQuestion.objectArrayWithKeyValuesArray(array) as? [HEQuestion]{
            result(data: modelArray, error: nil)
        }else{
            result(data: nil, error: NSError(domain: "转换失败", code: -1, userInfo: nil))
        }
    }
}
