//
//  UIDevice+Extention.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

extension UIDevice {
    class func currentDeviceScreenMeasurement() -> CGFloat {
        var deviceScree: CGFloat = 3.5
        
        if ((568 == ScreenHeight && 320 == ScreenWidth) || (1136 == ScreenHeight && 640 == ScreenWidth)) {
            deviceScree = 4.0;
        } else if ((667 == ScreenHeight && 375 == ScreenWidth) || (1334 == ScreenHeight && 750 == ScreenWidth)) {
            deviceScree = 4.7;
        } else if ((736 == ScreenHeight && 414 == ScreenWidth) || (2208 == ScreenHeight && 1242 == ScreenWidth)) {
            deviceScree = 5.5;
        }
        return deviceScree
    }
}
