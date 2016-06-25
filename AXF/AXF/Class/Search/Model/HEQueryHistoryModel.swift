//
//  HESearchHistory.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEQueryHistoryModel: NSObject {
    
    private static let path = HEFileTools.DocumentsPath+"searchHistory.plist"
    private static let instance = HEQueryHistoryModel()
    
    /**获取单例*/
    static func shareInstance()->HEQueryHistoryModel{
        return instance
    }
    
    /** 搜索历史数据*/
    lazy var  searchHistoryData:[String]? = {
        return NSArray.init(contentsOfFile: HEQueryHistoryModel.path) as? [String]
    }()
    
    /**保存历史数据,当退出程序时进行数据的持久化*/
    func savaHistory(){
        if let  searchDate = searchHistoryData{
            (searchDate as NSArray).writeToFile(HEQueryHistoryModel.path, atomically: true)
        }
    }
    
    /** 添加搜索数据*/
    func append(searchData:String){
        if searchHistoryData == nil{
            searchHistoryData = [String]()
        }
        if isContent(searchData){return}
        searchHistoryData?.append(searchData)
        postQueryHistroyChangedNoti()
    }
    
    /** 清空搜索历史*/
    func clearQueryHistory(){
        searchHistoryData = []
        HEFileTools.clearFile(HEQueryHistoryModel.path) {
        }
        postQueryHistroyChangedNoti()
    }
    
    /** 是否历史数据中是否包含关键字*/
    private func isContent(keyWord:String)->Bool{
        if searchHistoryData == nil{return false}
        for keyWordInHistory in searchHistoryData!{
            if keyWord == keyWordInHistory{ return true}
        }
        return false
    }
    
    /** 发送搜索历史数据改变的通知*/
    private func postQueryHistroyChangedNoti(){
        NSNotificationCenter.defaultCenter().postNotificationName(HENotiQueryHistroyChanged, object: nil)
    }
}
