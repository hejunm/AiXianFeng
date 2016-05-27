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
        setAppSubject()
        addNotification()
        setUpWindow()
        return true
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        print("applicationDidReceiveMemoryWarning")
        SDImageCache.sharedImageCache().clearMemory()
    }
    
    // MARK:- privete Method
    
    //设置主题
    private func setAppSubject() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        let navBarnAppearance = UINavigationBar.appearance()
        navBarnAppearance.translucent = false
    }
    //设置通知
    private func addNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showMainTabBarVC:", name: GuideViewControllerDidFinish, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showMainTabBarVC:", name: ADImageLoadFinished, object: nil)
    }
    //设置窗体
    private func setUpWindow(){
        self.window = UIWindow(frame: ScreenBounds)
        self.window!.makeKeyAndVisible()
        
        let isFirstOpen = NSUserDefaults.standardUserDefaults().objectForKey("isFirstOpen");
        if isFirstOpen == nil{ // 新手引导
            NSUserDefaults.standardUserDefaults().setObject("isFirstOpen", forKey: "isFirstOpen");
            self.window?.rootViewController = GuideViewController()
        }else{
            self.window?.rootViewController = ADViewController()
        }
    }
    //-通知响应
    func showMainTabBarVC(noteInfo: NSNotification){
        if noteInfo.name == GuideViewControllerDidFinish{
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
            self.window?.rootViewController = HEMainTabBarController()
        }else if noteInfo.name == ADImageLoadFinished{
            if let image = noteInfo.userInfo?["image"] as? UIImage{
                let vc = HEMainTabBarController()
                vc.adImage = image
                self.window?.rootViewController = vc
            }else{ //广告加载失败了
                self.window?.rootViewController = HEMainTabBarController()
            }
        }
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

