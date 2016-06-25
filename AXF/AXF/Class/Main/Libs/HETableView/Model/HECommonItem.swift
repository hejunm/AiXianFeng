//
//  HECommonItem.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/2.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECommenGroup:NSObject{
    var items:[HECommenItem] = [HECommenItem]()
    
    subscript(index: Int) -> HECommenItem {
        get {
            return items[index]
        }
        set(newValue) { // 执行赋值操作
            items[index] = newValue
        }
    }
}

class HECommonCheckBoxGroup:HECommenGroup{

}

class HECommenItem:NSObject{
    var id:String{return "HECommenItem"}
    /// 左侧图标
    var iconName:String?
    
    /// title
    var title:String?
    var titleColor:UIColor?
    /// 副标题
    var subTitle:String?
    
    /// cell height
    var height:CGFloat = 44
    
    /// 点击cell要执行的闭包
    var operationBlock:(()->())?
}

/// 右侧箭头
class HECommonItemArrow:HECommenItem{
    override var id:String{return "HECommonItemArrow"}
}

/// 只显示左侧label
class HECommonItemOnlyLeftLabel:HECommenItem{
    override var id:String{return "HECommonItemOnlyLeftLabel"}
    
    override init() {
        super.init()
        height = 30
    }
}
/// 只显示右边的, subTitle属性
class HECommonItemOnlyRightLabel:HECommenItem{
    override var id:String{return "HECommonItemOnlyRightLabel"}
    
    override init() {
        super.init()
        height = 30
    }
}

class HECommonItemCenterLabel:HECommenItem{
    override var id:String{return "HECommonItemCenterLabel"}
}

/// 可以修换状态
class HECommonItemSwitch:HECommenItem{
    override var id:String{return "HECommenItemSwitchItem"}
    var isSelected:Bool = false
    weak var group:HECommonCheckBoxGroup!
    
    init(group:HECommonCheckBoxGroup) {
        super.init()
        self.group = group
    }
}

/// 三个显示信息的label
class HECommonItemThreeLabel:HECommenItem{
    override var id:String{return "HECommonItemThreeLabel"}
    var secondTitle:String?
    var thirdTitle:String?
}



/// 费用明细
class HECommonItemDetailsCharges:HECommenItem{
    override var id:String{return "HECommonItemDetailsCharges"}
    /// 商品总额
    var amount:String = "￥0"
    /// 配送费
    var distributionCast:String = "￥0"
    /// 服务费
    var serviceCase:String = "￥0"
    /// 优惠券
    var coupon:String = "￥0"
    
    override init() {
        super.init()
        height = 115
    }
}

