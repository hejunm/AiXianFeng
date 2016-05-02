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
        return self.frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
        
    }
    /// 宽度
    var width: CGFloat {
        return self.frame.size.width
    }
    ///高度
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
}
