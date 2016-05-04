//
//  ADViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  广告控制器

import UIKit

class ADViewController: HEBaseViewController {
    
    private lazy var backImageView:UIImageView = UIImageView(frame: ScreenBounds)
    
    var imageName:String?{ //设置广告图片
        didSet{
            if imageName == nil { return}
            
            var placeholderImageName:String?
            switch UIDevice.currentDeviceScreenMeasurement(){
                case 3.5:
                    placeholderImageName = "iphone4"
                case 4.0:
                    placeholderImageName = "iphone5"
                case 4.7:
                    placeholderImageName = "iphone6"
                default:
                    placeholderImageName = "iphone6s"
            }
            
            //使用sdWebImage加载数据
            backImageView.sd_setImageWithURL(NSURL(string: imageName!), placeholderImage: UIImage(named: placeholderImageName!)) { (image, error, _,_) -> Void in
                if error != nil || image == nil{
                    NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadFinished, object: nil, userInfo: nil)
                    UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
                    return;
                }
                //延时发送通知， 将图片给主控制器。
                let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
                    
                    //发通知
                    let time1 = dispatch_time(DISPATCH_TIME_NOW,Int64(0.5 * Double(NSEC_PER_SEC)))
                    dispatch_after(time1, dispatch_get_main_queue(), { () -> Void in
                         NSNotificationCenter.defaultCenter().postNotificationName(ADImageLoadFinished, object: nil, userInfo: ["image":image])
                    })
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(backImageView)
        
        weak var tmpSelf = self
        ADModel.loadData { (data, error) -> Void in
            if data?.data?.img_name != nil {
                tmpSelf!.imageName = data?.data?.img_name!
            }
        }
    }
}
