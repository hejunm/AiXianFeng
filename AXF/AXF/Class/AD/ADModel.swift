//
//  ADModel.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import Foundation

class ADModel : ParentAD,DictModelProtocol{
    var code = -1
    var msg: String?
    var ad:[AD]?
    
    static func customClassMapping() -> [String: String]?{
        return ["ad":"AD"];
    }
}

class AD:NSObject {
    var title_AD:String?
    init(title:String) {
        title_AD = title
    }
    override init() {
        
    }
}

class ParentAD:NSObject{
    var parentVar1:String?
}




