//
//  HEAnimationTabBarController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/4/29.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  带动画的  TabBarController

//    当切换 tabBar时，选中的tabBar会抖动几下，并且高亮。 取消选中的tabBar会恢复nomal状态



import UIKit


protocol AnimationForTabBarProtocol{
    
    func playAnimation(icon : UIImageView?, textLabel : UILabel?)
    
    func deselectAnimation(icon : UIImageView?, textLabel : UILabel?)
    
    func selectedState(icon : UIImageView?, textLabel : UILabel?)
    
}

class BounceAnimation:NSObject,AnimationForTabBarProtocol {
   
    var duration = 0.7
    
    func playAnimation(icon: UIImageView?, textLabel: UILabel?) {
        
        if let imageView = icon{
            
            let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
            bounceAnimation.duration = NSTimeInterval(duration)
            bounceAnimation.calculationMode = kCAAnimationCubic
            
            imageView.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
        }
        
        if let _ = textLabel{
            
        }
    }
    
    func deselectAnimation(icon: UIImageView?, textLabel: UILabel?) {}
    
    func selectedState(icon: UIImageView?, textLabel: UILabel?) {}
}



class HEAnimationTabBarController: UITabBarController {
    
    lazy var animationForTabBarItem:AnimationForTabBarProtocol =  BounceAnimation()
    
    var iconAndLabels:[(icon:UIImageView,label:UILabel)] = []
    
    var isFirstLoadThisController = true
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLoadThisController{
            if let items = self.tabBar.items{
                
                for (index,item) in items.enumerate(){
                   
                    item.tag = index
                    
                    assert(item.image != nil, "add image icon in UITabBarItem")
                    assert(item.selectedImage != nil, "add selectedImage in UITabBarItem")
                    assert(item.title != nil, "add title in UITabBarItem")
                    
                    let viewContainer = createViewContainerAt(index)
                    createCustomIconsIn(viewContainer, item: item)
                    
                    item.image = nil  //这样系统的就不会显示出来
                    item.title = nil
                    item.selectedImage = nil
                }
            }
            isFirstLoadThisController = false
        }
    }
    
    private func createViewContainerAt(index :Int) ->UIView{
        
        let width:CGFloat = CGFloat(ScreenWidth) / CGFloat(self.tabBar.items!.count)
        let height:CGFloat = self.tabBar.bounds.height
        let container:UIView = UIView(frame: CGRectMake(width * CGFloat(index),0,width,height))
        container.backgroundColor = UIColor.clearColor()
        
        self.tabBar.addSubview(container)
        
        return container
    }
    
    private func createCustomIconsIn(viewContainer:UIView,item:UITabBarItem){
        
        let count = self.tabBar.items!.count
        
        //image
        let imageW:CGFloat = 21
        let imageX:CGFloat = (ScreenWidth / CGFloat(count) - imageW) * 0.5
        let imageY:CGFloat = 8
        let imageH:CGFloat = 21
        let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
        icon.image = item.image
        icon.highlightedImage = item.selectedImage
        icon.tintColor = UIColor.clearColor()
        
        //第一个默认是选中的
        if(item.tag==0){
            icon.highlighted = true
        }
        
        // text
        let textLabel = UILabel()
        textLabel.frame = CGRectMake(0, 32, ScreenWidth / CGFloat(count), 49 - 32)
        textLabel.text = item.title
        textLabel.backgroundColor = UIColor.clearColor()
        textLabel.font = UIFont.systemFontOfSize(10)
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.textColor = UIColor.grayColor()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.addSubview(icon)
        viewContainer.addSubview(textLabel)
        
        iconAndLabels.append((icon,textLabel))
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        selectItemFrom(selectedIndex, toIndex: item.tag)
    }
    
    
    func selectItemFrom(from:Int, toIndex:Int){
       
        let fromImageView = iconAndLabels[from].icon
        let toImageView =  iconAndLabels[toIndex].icon
        
        fromImageView.highlighted = false
        toImageView.highlighted = true
        animationForTabBarItem.playAnimation(toImageView, textLabel: nil)
    }
}
