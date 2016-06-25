//
//  HEWebViewController.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEWebViewController: HEBaseViewController {
    
    //MARK: 参数
    private let webView:UIWebView = UIWebView(frame: ScreenBounds)
    private let progressView = HEAniProgressView(frame: CGRectMake(0, 0, ScreenWidth, 3))
    private var url:String?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.addSubview(webView)
        progressView.backgroundColor = HENavigationYellowColor
        webView.addSubview(progressView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     初始化浏览器
     
     - parameter title: 导航title
     - parameter url:   加载页面的url
     */
    convenience init(title:String?,url:String?){
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = title
        self.url = url
        if self.url != nil{
            webView.loadRequest(NSURLRequest(URL:NSURL(string: self.url!)!))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildRightBarButtonItem()
        view.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        webView.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        webView.delegate = self
        webView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
    }
    
    private func buildRightBarButtonItem() {
        let rightButton = UIButton(frame: CGRectMake(0, 0, 60, 44))
        rightButton.setImage(UIImage(named: "v2_refresh"), forState: UIControlState.Normal)
        rightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -53)
        rightButton.addTarget(self, action: #selector(HEWebViewController.refreshClick), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    //MARK: refreshClick
    func refreshClick(){
        if self.url != nil{
            webView.loadRequest(NSURLRequest(URL:NSURL(string: self.url!)!))
        }
    }
}

extension HEWebViewController:UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView){
        progressView.startLoadProgressAni()
    }
    func webViewDidFinishLoad(webView: UIWebView){
        progressView.endLoadProgressAni()
    }
}

class HEAniProgressView:UIView{
    
    //重写计算性属性
    override var width:CGFloat{
       get{
        return super.width
        }
        set(newValue){
            super.width = newValue
            if newValue == self.viewWidth{
                self.hidden = true
            }
        }
    }
    
    var viewWidth:CGFloat = 0
    
    /**  初始化时必须制定其 width */
    override init(frame: CGRect) {
        super.init(frame: frame)
        if frame.size.width==0{
            fatalError("frame.size.width con't be 0")
        }
        viewWidth = frame.size.width
        width = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 开始加载进度动画*/
    func startLoadProgressAni(){
        weak var tmpSelf = self
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            tmpSelf!.width = tmpSelf!.viewWidth*0.6
            }) { (finished) -> Void in
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.4 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        tmpSelf!.width = tmpSelf!.viewWidth*0.8
                    })
                })
        }
    }
    
    /**结束加载进度动画*/
    func endLoadProgressAni(){
        weak var tmpSelf = self
        UIView.animateWithDuration(0.4) { () -> Void in
            tmpSelf!.width = tmpSelf!.viewWidth
        }
    }
}

