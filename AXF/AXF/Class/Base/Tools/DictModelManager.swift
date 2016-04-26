//
//  HeExtention.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  字典转模型  / 模型传字典

import Foundation


/** 当字典中存在数组， 并且数组中保存的值得类型是字典， 那么就需要指定数组中的字典对应的类类型。 
 这里以键值对的形式保存
 eg 字典如下：
 key: [[key1:value1, key2:value2],[key1:value3, key2:value4],[key1:value5, key2:value6]]
 
 key：  key值
 value: 字典[key1:value1, key2:value2] 对应的模型
 
 */

@objc public protocol DictModelProtocol{
    static func customClassMapping() -> [String: String]?
}

class DictModelManager {
    
    private init(){ }
    private static let instance  = DictModelManager()
    class func shareManager() ->DictModelManager {
        return instance
    }
    

    /**
        字典传模型
        dict: 要进行转换的字典
        cls:  转换成的模型类 的类型
    */
    func objectFromDictionary(dict: NSDictionary, var cls: AnyClass)->AnyObject?{
        let obj:AnyObject = (cls as! NSObject.Type).init()                    // 创建模型实例
        while("NSObject" !=  "\(cls)" ){
            var count:UInt32 = 0
            let properties =  class_copyPropertyList(cls, &count)
            for i in 0..<count{
                let property = properties[Int(i)]                                 //获取模型中的某一个属性
                let propertyKey = String.fromCString(property_getName(property))!         //模型中属性名称
                let propertyType = String.fromCString(property_getAttributes(property))!  //模型中属性类型
                
                var value:AnyObject? = dict[propertyKey]
                if let tempValue = value{
                    let dictType = "\(tempValue.classForCoder)"
                    if dictType == "NSDictionary"{               //某个key对应一个字典， 那么递归
                        if let subModel = getType(propertyType){ //找出这个key对应的模型类名称
                           value = objectFromDictionary(value as! NSDictionary,cls:NSClassFromString(subModel)!)
                        }else{ //出错了
                            print("你定义的模型与字典不匹配。 字典中的键\(propertyKey)  对应一个模型")
                            assert(true)
                            
                        }
                    }else if dictType == "NSArray"{  //某个key 对应的是数组。 数组中存放字典。 将字典转换成模型。 如果协议中没有定义映射关系，就不做处理
                        if cls.respondsToSelector("customClassMapping") {
                            if var className = cls.customClassMapping()?[propertyKey]{
                                let bundlePath = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
                                className =  bundlePath+"."+className
                                value = objectFromArray(value as! NSArray,cls: NSClassFromString(className)!)
                            }
                        }
                        
                    }
                }
                obj.setValue(value, forKey: propertyKey)
            }
            free(properties) //释放内存
            cls = cls.superclass()! //处理父类
        }
        return obj
    }
    
    /**
     将字典数组转换成模型数组
     array: 要转换的数组
     cls：  数组内的字典要转换成的模型（最外层的）
     
     当数组中嵌套数组， 内部的数组包含字典，cls就是内部数组中的字典对应的模型
     */
    func objectFromArray(array: NSArray, cls: AnyClass)->NSArray?{
        if array.count == 0{
            return nil
        }
        var result = [AnyObject]()
        for item in array{
            let type = "\(item.classForCoder)"
            if type == "NSDictionary"{
                if let model = objectFromDictionary(item as! NSDictionary, cls: cls){
                    result.append(model)
                }
            }else if type == "NSArray"{
                if let model =  objectFromArray(item as! NSArray,cls: cls){
                    result.append(model)
                }
            }else{
                result.append(item)
            }
        }
        if result.count==0{
            return nil
        }else{
            return result
        }
    }
    
    
//    //模型转字典
//    func objectToKeyValues(let object:AnyObject)->[String: AnyObject]?{
//       
//        _ = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String  //用来判断一个模型是自定义的
//        var result = [String: AnyObject]() //保存结果
//        let classType = object.classForCoder
//        while("NSObject" !=  "\(classType)" ){
//            var count:UInt32 = 0
//            let properties = class_copyPropertyList(classType, &count)
//            for i in 0..<count{
//                let property = properties[Int(i)]  //获取模型中的某一个属性
//                let propertyKey = String.fromCString(property_getName(property))!         //模型中属性名称
//                let propertyType = String.fromCString(property_getAttributes(property))!  //模型中属性类型
//
//                
//                var value = object.valueForKey(propertyKey)
//                
//                
//                if let tempValue = value{
//                    /**
//                    1, 自定义的类
//                    2, NSArray
//                    3, 普通的数据类型
//                    
//                    
//                    
//                    */
//                }
//                result[propertyKey] = value
//            }
//            free(properties)  //在便利是， 会把父类的属性一起便利吗？ 
//            //classType = classType.superclass()
//        }
//        if result.count == 0{
//            return nil
//        }
//        return result
//    }
    
    
    
    
    
    /**
        let propertyType = String.fromCString(property_getAttributes(property))! 获取属性类型
        到这个属性的类型是自定义的类时， 会得到下面的格式： T+@+"+..+工程的名字+数字+类名+"+,+其他,
        而我们想要的只是类名，所以要修改这个字符串
    */
    func getType(var code:String)->String?{
        let bundlePath = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        if !code.containsString(bundlePath){ //不是自定义类
            return nil
        }
        code = code.componentsSeparatedByString("\"")[1]
        if let range = code.rangeOfString(bundlePath){
            code = code.substringFromIndex(range.endIndex)
            var numStr = "" //类名前面的数字
            for c:Character in code.characters{
                if c <= "9" && c >= "0"{
                    numStr+=String(c)
                }
            }
            
            if let numRange = code.rangeOfString(numStr){
               code = code.substringFromIndex(numRange.endIndex)
            }
            return bundlePath+"."+code
        }
        return nil
    }
    
}



