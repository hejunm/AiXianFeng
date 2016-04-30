//
//  HEMainTabBarController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMainTabBarController: HEAnimationTabBarController {
    
    private var adImageView:UIImageView?
    
    var adImage:UIImage?{
        didSet{
            if adImage != nil {
                adImageView = UIImageView(frame: self.view.bounds)
                adImageView?.image = adImage
                adImageView!.contentMode = .ScaleAspectFill
                self.view.addSubview(adImageView!)
                
                weak var tmpSelf = self
                UIView.animateWithDuration(2.0, animations: { () -> Void in
                        tmpSelf!.adImageView!.transform = CGAffineTransformMakeScale(1.2, 1.2)
                        tmpSelf!.adImageView!.alpha = 0
                    }, completion: { (finish) -> Void in
                        tmpSelf!.adImageView!.removeFromSuperview()
                        tmpSelf!.adImageView = nil
                })
                
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildChildVCs()
    }
    
    private func buildChildVCs(){
        
        addChildViewController(UIViewController(), title: "首页", imageName: "v2_home", selectedImageName: "v2_home_r")
        addChildViewController(UIViewController(), title: "闪电超市", imageName: "v2_order", selectedImageName: "v2_order_r")
        addChildViewController(UIViewController(), title: "购物车", imageName: "shopCart", selectedImageName: "shopCart")
        addChildViewController(UIViewController(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r")
    }
    
    private func addChildViewController(vc:UIViewController,title:String,imageName:String,selectedImageName:String){
        
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        
        self.addChildViewController(vc)
    }
}
