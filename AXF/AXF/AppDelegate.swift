//
//  AppDelegate.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
//        let dict = ["code":2,
//                    "msg":"success",
//                    "parentVar":"hha 我是父类的",
//                    "data":[
//                                ["title":"he1",
//                                 "img_name":"my1.png"
//                                ],
//                                ["title":"he2",
//                                "img_name":"my2.png"
//                                ]
//                            ]
//                    ];
//       var model = DictModelManager.shareManager().objectFromDictionary(dict, cls: ADModel.self)as?ADModel
        
        var adModel = ADModel();
        adModel.code = -5;
        adModel.msg = "hello"
        
        var dict =  DictModelManager.shareManager().objectToKeyValues(adModel)
       return true
    }
    
    func addNotification(){
        //新手引导结束
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showMainTabBarVC", name: GuideViewControllerDidFinish, object: nil)
        
    }
    
    func setUpWindow(){
        self.window = UIWindow(frame: ScreenBounds)
        self.window!.makeKeyAndVisible()
        
        let isFirstOpen = NSUserDefaults.standardUserDefaults().objectForKey("isFirstOpen");
        if isFirstOpen == nil{ //第一次, 新手引导
            NSUserDefaults.standardUserDefaults().setObject("isFirstOpen", forKey: "isFirstOpen");
            self.window?.rootViewController = GuideViewController()
        }else{//广告
            
        }
    }
    
    //MARK: -通知响应
    func showMainTabBarVC(){
        
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

