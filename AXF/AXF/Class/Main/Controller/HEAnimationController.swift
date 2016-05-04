//
//  HEAnimationController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/1.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEAnimationController: HEBaseViewController {
    
    lazy var animationLayers = [CALayer]()
    
    func addProductsAnimation(imageView:UIImageView){
        
        //创建图层
        let productLayer = CALayer()
        productLayer.frame = imageView.convertRect(imageView.bounds, toView: view)
        productLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(productLayer)
        animationLayers.append(productLayer)
        
        //创建动画
        let fromP = productLayer.position
        let toP = CGPoint(x: view.width*3/4-20 , y: view.height - 40)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, fromP.x, fromP.y);
        CGPathAddCurveToPoint(path, nil, fromP.x, fromP.y - 30, toP.x, fromP.y - 30, toP.x, toP.y);
        positionAnimation.path = path;
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(CATransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup() //动画结束后， 默认将动画从图层中删除
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation];
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self;
        
        productLayer.addAnimation(groupAnimation, forKey: "cartParabola")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if self.animationLayers.count > 0 {
            let transitionLayer = animationLayers[0]
            transitionLayer.removeFromSuperlayer()
            animationLayers.removeFirst()
        }
    }
}
