//
//  HEFileTools.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  文件操作工具
/**
 
 沙盒包含:
       应用程序包
       Documents    持久化的数据，
       tmp          临时目录， 只要重新启动系统自动清除
       Library
            cache   缓存
            Preferences  配置信息\SQLite
 */
import UIKit

class HEFileTools: NSObject {
    static let fileManager =  NSFileManager.defaultManager()
    /// 沙盒路径
    static let SandBoxPath = NSHomeDirectory()
    /// Documents
    static let DocumentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
    /// Tmp
    static let TmpPath = NSTemporaryDirectory()
    /// Library
    static let LibraryPath = NSSearchPathForDirectoriesInDomains(.LibraryDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
    /// CachePath
    static let CachePath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
    /// Preferences
    static let PreferencesPath = NSSearchPathForDirectoriesInDomains(.PreferencePanesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
    
    /**获取文件/文件夹大小*/
    class func getFileSize(path:String) ->UInt64{
        var isDir : ObjCBool = false
        var fileSize:UInt64 = 0
        if !fileManager.fileExistsAtPath(path, isDirectory: &isDir){
            //fatalError("file in path:\(path) don't exist")
            print("file in path:\(path) don't exist")
        }
        if !isDir{ //file
            if let fileAttri = try? fileManager.attributesOfItemAtPath(path) as NSDictionary{
                return fileAttri.fileSize()
            }
        }else{ //dir
            if let chilerFiles = fileManager.subpathsAtPath(path){
                for fileName in chilerFiles {
                    let tmpPath = path as NSString
                    let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                    var isDirectory: ObjCBool = false
                    if fileManager.fileExistsAtPath(fileFullPathName, isDirectory: &isDirectory){
                        if isDirectory{ continue}
                    }
                    fileSize += getFileSize(fileFullPathName)
                }
            }
        }
        return fileSize
    }
    
    /**
     删除文件/文件夹 同步
     
     - parameter path:        要删除的文件/文件夹路径
     - parameter complete:    结束后执行的回调
     */
    class func clearFile(path:String,complete:() -> ()){
        var isDir : ObjCBool = false
        if !fileManager.fileExistsAtPath(path, isDirectory: &isDir){
            print("file in path:\(path) don't exist")
        }
        do {
            try fileManager.removeItemAtPath(path)
            complete()
        } catch {
            print("an error occurs when clearFile\(error)")
        }
    }
    
    /**
     删除文件/文件夹 异步
     
     - parameter path:        要删除的文件/文件夹路径
     - parameter complete:    结束后执行的回调
     */
    class func clearFileAsync(path:String,complete:() -> ()){
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            var isDir : ObjCBool = false
            if !fileManager.fileExistsAtPath(path, isDirectory: &isDir){
                print("file in path:\(path) don't exist")
                return
            }
            do {
                try fileManager.removeItemAtPath(path)
            } catch _ {
                print("an error occurs when clearFile\(path)")
            }
            dispatch_async(dispatch_get_main_queue(), { 
                complete()
            })
        }
    }
    /**
     删除文件夹里面的内容
     
     - parameter path:     文件夹路径
     - parameter complete: 删除结束执行的操作
     */
    class func clearContentsInDirectory(path:String,complete:() -> ()){
        var isDir : ObjCBool = false
        if !fileManager.fileExistsAtPath(path, isDirectory: &isDir){
            print("file in path:\(path) don't exist")
            return
        }
        if !isDir{
            print("path most be a directory")
            return
        }
        if let chilerFiles = try? fileManager.contentsOfDirectoryAtPath(path){
            for fileName in chilerFiles {
                let tmpPath = path as NSString
                let fileFullPathName = tmpPath.stringByAppendingPathComponent(fileName)
                do {
                    try fileManager.removeItemAtPath(fileFullPathName)
                } catch  {
                    print("an error occurs when clearFile\(error)")
                }
            }
        }
        complete()
    }
}

extension UInt64{
    func formatFileSize()->Double{
        return Double(self)/1024.0/1024.0
    }
}
