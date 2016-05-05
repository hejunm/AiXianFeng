//
//  Theme.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

//MARK:   尺寸

public let NavigationH: CGFloat = 64
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds: CGRect = UIScreen.mainScreen().bounds

// MARK: - 常用颜色
public let HEGlobalBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)
public let HENavigationYellowColor = UIColor.colorWithCustom(253, g: 212, b: 49)
public let HETextGreyColol = UIColor.colorWithCustom(130, g: 130, b: 130)
public let HETextBlackColor = UIColor.colorWithCustom(50, g: 50, b: 50)

// MARK: -字体大小
public let HENavigationTextViewFont = UIFont.systemFontOfSize(10)

// MARK: -通知
public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"
public let ADImageLoadFinished =  "ADImageLoadFinished"

public let HEHomeViewControllerForceImageClick = "HEHomeViewControllerForceImageClick"  //点击了轮播图片
public let HEHomeViewControllerIconClick = "HEHomeViewControllerIconClick"              //首页icon
public let HEHomeHeaderViewHeightChanged = "HEHomeHeaderViewHeightChanged"              //首页头部高度改变




// MARK: - Home 属性
public let HEHotViewMargin: CGFloat = 10
public let HEHomeCollectionViewCellMargin: CGFloat = 8
public let HEHomeCollectionTextFont = UIFont.systemFontOfSize(14)
public let HEHomeCollectionCellAnimationDuration: NSTimeInterval = 1.0

