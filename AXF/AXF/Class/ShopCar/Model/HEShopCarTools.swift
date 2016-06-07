//
//  HEShopCarTools.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import Foundation


class HEShopCarTools: NSObject {
    
    private var products = [Goods]()
    
     /** 获取单例对象*/
    private static let instance = HEShopCarTools()
    class  var shareShopCarTools:HEShopCarTools{
        return instance
    }
    
    private override init() {
        super.init()
    }
    
    /** 将goods添加到购物车中*/
    func addProduct(goods:Goods){
        for item in self.products{
            if item.id == goods.id{
                return
            }
        }
        self.products.append(goods)
    }
    
    /**将goods从购物车中删除*/
    func reduceProduct(goods:Goods){
        for i in 0..<self.products.count{
            let item = self.products[i]
            if item.id == goods.id{
                self.products.removeAtIndex(i)
                break
            }
        }
        if getProduceCount() == 0{
            NSNotificationCenter.defaultCenter().postNotificationName(HENotiShopCarNoProduce, object: nil)
        }
    }
    
    /**返回商品数量*/
    func getProduceCount()->Int{
        return self.products.count
    }
    
    /** 获取所有的商品 */
    func getAllProduce()->[Goods]?{
        if products.count == 0{return nil}
        return products
    }
    
    /**
     获取购物车中商品总金额
     - returns: String类型
     */
    func getTotalAmount()->String{
        var totalAmount:Double = 0.0
        for i in 0..<self.products.count{
            let item = self.products[i]
            totalAmount += Double(item.price!)! * Double(item.userBuyNumber)
        }
        return "\(totalAmount)"
    }
}
