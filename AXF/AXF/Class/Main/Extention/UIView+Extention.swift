//
//  UIView+Extention.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

/// 对UIView的扩展
extension UIView {
    /// X值
    var x: CGFloat {
        get{
            return self.frame.origin.x
        }
        set(newValue){
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        
    }
    /// Y值
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set(newValue){
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        
    }
    /// 宽度
    var width: CGFloat {
        get{
            return self.frame.size.width
        }
        set(newValue){
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    ///高度
    var height: CGFloat {
        get{
            return self.frame.size.height
        }
        set(newValue){
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var size: CGSize {
        get{
            return self.frame.size
        }
        set(newValue){
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    var point: CGPoint {
        get{
           return self.frame.origin
        }
        set(newValue){
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
}
