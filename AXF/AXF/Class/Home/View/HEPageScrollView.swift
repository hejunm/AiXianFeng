//
//  HEPagerScrollView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/4.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  循环滚动的scrollView

import UIKit

class HEPageScrollView: UIView {
    
    var scrollView : UIScrollView!
    var pageControl :UIPageControl!
    var timer:NSTimer!
    private let maxFocusCount:Int = 3
    var focus:[Activitie]!{
        didSet{
            if focus==nil {
                print("focus 是空")
                return
            }
            pageControl.numberOfPages = focus.count
            pageControl.currentPage = 0
            setNeedsLayout()
            updata()
            startTimer()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildScrollView()
        buildPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildScrollView(){           //只需要三个就可以实现所有的轮播
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.frame = self.bounds
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSizeMake(width * CGFloat(maxFocusCount), height)
        addSubview(scrollView)
        
        for i in 0..<maxFocusCount{
            let imageView = ForceImageView(frame: CGRectMake(CGFloat(i)*width, 0, width, height))
            imageView.contentMode = .ScaleAspectFill
            scrollView.addSubview(imageView)
        }
    }
    
    func buildPageControl(){
        pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_normal")!)
        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_selected")!)
        addSubview(pageControl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let pageControlSize = pageControl.sizeForNumberOfPages(pageControl.numberOfPages)
        pageControl.frame = CGRectMake(width-pageControlSize.width-10, height-pageControlSize.height, pageControlSize.width, pageControlSize.height)
    }
    
    func updata(){
        if pageControl.numberOfPages==0{
            return
        }
        //每一次更新都是根据当前  pageControl.currentPage来进行
        if let imageViews = scrollView.subviews as? [ForceImageView]{
            for (i,imageView) in imageViews.enumerate(){
                var index = pageControl.currentPage
                if i==0 {
                    index--
                }else if i==2{
                    index++
                }
                
                if index<0{
                    index = pageControl.numberOfPages - 1
                }else if index >= pageControl.numberOfPages{
                    index = 0
                }
                imageView.data = focus[index]
                imageView.tag = index          //标记页
            }
        }
        scrollView.setContentOffset(CGPointMake(scrollView.width, 0), animated: false)
    }
    
    func startTimer(){
        if timer == nil{
            timer = NSTimer(timeInterval: 3.0, target: self, selector: "next", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        }
    }
    
    func endTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    func next(){
        scrollView.setContentOffset(CGPointMake(scrollView.width*2, 0), animated: true)
    }
}

//MARK: --滚动试图的代理
extension HEPageScrollView:UIScrollViewDelegate{
    
    //判断当前第几页
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offsetX = scrollView.contentOffset.x;
        offsetX = offsetX + (scrollView.width * 0.5)
        let page = Int(offsetX / scrollView.width)
        
        let imageView = scrollView.subviews[page]
        pageControl.currentPage = imageView.tag
    }
    
     //停止定时器
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
       endTimer()
    }
    
     //开启定时器
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       startTimer()
    }
    
     //更新
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var offsetX = scrollView.contentOffset.x;
        offsetX = offsetX + (scrollView.width * 0.5)
        let page = Int(offsetX / scrollView.width)
        if page==0 || page==2{ //拖动时做个小的优化
            updata()
        }
    }
    
    //调用 setContentOffset(, animated:) 后会调用， 必须有动画，否则不会调用这个代理。
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
       updata()
    }
}

//MARK: --自定义的轮播图中使用的imageView
class ForceImageView: UIImageView {
    lazy var placeHolderImage:UIImage = UIImage(named: "v2_placeholder_full_size")!
    
    var data:Activitie!{
        didSet{
            self.sd_setImageWithURL(NSURL(string: data.img!), placeholderImage: placeHolderImage)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: "imageViewClick")
        addGestureRecognizer(tap)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageViewClick(){ //点击时发送通知
        if data != nil{
        NSNotificationCenter.defaultCenter().postNotificationName(HEHomeViewControllerForceImageClick, object: nil, userInfo: ["focus":data])
        }
    }
}


