//
//  Theme.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

//MARK:   尺寸

public let HEMargin_10:CGFloat = 10
public let NavigationH: CGFloat = 64
public let HETabBarH:CGFloat = 49
public let ScreenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
public let ScreenBounds: CGRect = UIScreen.mainScreen().bounds

// MARK: - 常用颜色
public let HEGlobalBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)
public let HENavigationYellowColor = UIColor.colorWithCustom(253, g: 212, b: 49)
public let HETextGreyColol = UIColor.colorWithCustom(130, g: 130, b: 130)
public let HETextBlackColor = UIColor.colorWithCustom(50, g: 50, b: 50)
public let HEWhiteColor = UIColor.colorWithCustom(255, g: 255, b: 255)

// MARK: -字体大小
public let HENavigationTextViewFont = UIFont.systemFontOfSize(10)
public let HEHomeCollectionTextFont = UIFont.systemFontOfSize(14)

// MARK: -通知
public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"
public let ADImageLoadFinished =  "ADImageLoadFinished"
public let HENotiShopCarNoProduce = "HENotiShopCarNoProduce"        //购物车中没有数据时发送
public let HENotiShopCarTotalAmountChanged = "HENotiShopCarTotalAmountChanged" //购物车中的金额改变
public let HENotiCheckBoxGroupSelectChanged = "HENotiCheckBoxGroupSelectChanged" //单选改变时触发

// MARK: - Home 属性
public let HEHomeViewControllerForceImageClick = "HEHomeViewControllerForceImageClick"  //点击了轮播图片
public let HEHomeViewControllerIconClick = "HEHomeViewControllerIconClick"              //首页icon
public let HEHomeHeaderViewHeightChanged = "HEHomeHeaderViewHeightChanged"              //首页头部高度改变
public let HEHotViewMargin: CGFloat = HEMargin_10
public let HEHomeCollectionViewCellMargin: CGFloat = 8
public let HEHomeCollectionCellAnimationDuration: NSTimeInterval = 1.0

