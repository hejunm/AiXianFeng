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
        //1,  最简单的字典转模型
        //var dict = ["name":"hejunmeng","age":20]
        //var user = User.objectWithKeyValues(dict) as? User
        
//       //2, 模型中包裹模型
//        let dict = ["text":"Agree!Nice weather!",
//                     "user":["name":"Jack",
//                             "icon":"lufy.png"
//                            ],
//            "retweetedStatus":["text":"Nice weather!",
//                                "user":["name":"Rose",
//                                        "icon":"nami.png"
//                                       ]
//              ]
//        ]
//        var status = Status.objectWithKeyValues(dict) as? Status
        
        
//        //3,字典中包裹数组， 数组中的元素是赢一个模型对应的字典
//        let dict =  ["code":-90,
//            "msg":"这是一条msg",
//            "parentVar1":"parent_______",
//            "ad":[["title_AD":"ad1,title"],["title_AD":"ad2,title"],["title_AD":"ad3,title"]]
//        ]
//        let adModel = ADModel.objectWithKeyValues(dict) as? ADModel
//        
//        if let count = adModel?.ad?.count{
//            for var i in 0..<count{
//                var item  = adModel?.ad![i];
//                print(item)
//                
//            }
//        }
        
//        //4, 将一个字典数组转成模型数组
//        let arrayOfStatus = [["text":"Agree!Nice weather!",
//                             "user":["name":"Jack",
//                                     "icon":"lufy.png"
//                                    ],
//                            "retweetedStatus":["text":"Nice weather!",
//                                                "user":["name":"Rose",
//                                                        "icon":"nami.png"
//                                                       ]
//                                               ]
//                            ],
//                            ["text":"Agree!Nice weather!",
//                              "user":["name":"Jack",
//                                       "icon":"lufy.png"
//                                     ],
//                            "retweetedStatus":["text":"Nice weather!",
//                                                "user":["name":"Rose",
//                                                        "icon":"nami.png"
//                                                       ]
//                                               ]
//                            ]]
//        
//        var status = Status.objectArrayWithKeyValuesArray(arrayOfStatus)
//        
//        for var item in (status! as! [Status]){
//            print(item.description)
//        }
        
        
    
        
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

