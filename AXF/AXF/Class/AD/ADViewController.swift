//
//  ADViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  广告控制器

import UIKit

class ADViewController: BaseViewController {
    
    private lazy var backImageView:UIImageView = {  //懒加载， 在使用的时候才去创建
        let imageView = UIImageView(frame: ScreenBounds)
        return imageView
    }()
    
    
     var imageName:String?{ //设置广告图片
        didSet{
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
                 
                    return;
                }
                //获得到图片
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(backImageView)
        
        //从网络获取数据， 并将获取的广告图片显示出来
        
        
    }
}
