//
//  HEMainTabBarController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/30.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMainTabBarController: HEAnimationTabBarController {
    /**
     可以选择的控制器
     
     - Home:        首页
     - SuperMarket: 闪电超市
     - ShopCart:    购物车
     - Mine:        我的
     */
    enum OptionalVC{
        case Home
        case SuperMarket
        case ShopCart
        case Mine
    }
    
    lazy private var adImageView:UIImageView! = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .ScaleAspectFill
        self.view.addSubview(imageView)
        return imageView
    }()

    var adImage:UIImage?{
        didSet{
            if adImage != nil {
                adImageView.image = adImage
                weak var tmpSelf = self
                UIView.animateWithDuration(2.0,
                    animations: { () -> Void in
                        tmpSelf!.adImageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                        tmpSelf!.adImageView.alpha = 0
                    },
                    completion: { (finish) -> Void in
                        tmpSelf!.adImageView.removeFromSuperview()
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
        addChildViewController(HEHomeViewController(), title: "首页", imageName: "v2_home", selectedImageName: "v2_home_r")
        addChildViewController(HESuperMarketViewController(), title: "闪电超市", imageName: "v2_order", selectedImageName: "v2_order_r")
        addChildViewController(UIViewController(), title: "购物车", imageName: "shopCart", selectedImageName: "shopCart")
        addChildViewController(UIViewController(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r")
    }
    
    private func addChildViewController(vc:UIViewController,title:String,imageName:String,selectedImageName:String){
        
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        self.addChildViewController(HEBaseNavigationController(rootViewController: vc))
    }
    
    /**
     切换到指定控制器
     - parameter vc:
     */
    func switchVC(vc:OptionalVC){
        let fromIndex = selectedIndex
        var toIndex :Int = 0
        switch vc{
            case .Home:
                toIndex = 0
                break
            case .SuperMarket:
                toIndex = 1
                break
            case .ShopCart:
                toIndex = 2
                break
            case .Mine:
                toIndex = 3
                break
        }
        selectedIndex = toIndex
        selectItemFrom(fromIndex, toIndex: toIndex)
    }
}
