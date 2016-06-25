//
//  HEMineSettingVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/7.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  设置

import UIKit

class HEMineSettingVC: HECommonTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buildGroup()
        navigationItem.title = "设置"
    }
    
    private func buildGroup(){
        // group1
        let group1 = HECommenGroup()
        
        let aboutMe = HECommonItemArrow()
        aboutMe.title = "关于作者"
        group1.items.append(aboutMe)
        
        let clearCatch = HECommenItem()
        clearCatch.title = "清除缓存"
        clearCatch.subTitle = getCacheSize()  //获取缓存大小
        weak var tmpSelf = self
        clearCatch.operationBlock = {
            HEFileTools.clearContentsInDirectory(HEFileTools.CachePath, complete: {
                clearCatch.subTitle = tmpSelf!.getCacheSize() //获取缓存大小
                tmpSelf!.tableView.reloadData()
            })
        }
        group1.items.append(clearCatch)
        
        //group2
        let group2 = HECommenGroup()
        let exit = HECommonItemCenterLabel()
        exit.title = "退出当前账户"
        group2.items.append(exit)
        
        groups = [group1,group2]
        
    }
    
    private func getCacheSize()->String{
        let cacheSize = HEFileTools.getFileSize(HEFileTools.CachePath).formatFileSize()
        return String().stringByAppendingFormat("%.2fM",cacheSize)
    }
}
