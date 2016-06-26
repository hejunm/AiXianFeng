//
//  HEQRCodeVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/25.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  二维码扫描控制器

import UIKit
import AVFoundation

class HEQRCodeVC: HEBaseViewController {
   
    private var titleLabel = UILabel()
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var animationLineView = UIImageView()
    private var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = HEGlobalBackgroundColor
        buildNavi()
        buildInputAVCaptureDevice()
        buildDecorateView()
        buildTitleLabel()
        buildAnimationLineView()
    }
    
    func buildNavi(){
        navigationItem.title = "店铺二维码"
        navigationController?.navigationBar.barTintColor = UIColor.colorWithCustom(249, g: 250, b: 253)
    }
    
    func buildTitleLabel(){
        titleLabel.textColor = HETextGreyColol
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.frame = CGRectMake(0, 340, view.width, 30)
        titleLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(titleLabel)
    }
    
    func buildInputAVCaptureDevice(){
        titleLabel.text = "将店铺二维码对准方块内既可收藏店铺"
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else{
            titleLabel.text = "摄像头不可用。。。换个真机试试"
            return
        }
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        //设置扫描区域 CGRectMake(y1/y, x1/x, h1/h, w1/w)
        captureMetadataOutput.rectOfInterest = CGRectMake(100/(view.height-NavigationH), 0.2, view.width*0.6/(view.height-NavigationH), 0.6)

        captureSession = AVCaptureSession()
        captureSession?.addInput(input)
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_queue_create("myQueue", nil))
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
        
       
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
    }
    
    private func buildTransparentView(frame: CGRect) {
        let tView = UIView(frame: frame)
        tView.backgroundColor = UIColor.blackColor()
        tView.alpha = 0.5
        view.addSubview(tView)
    }
    
    private func buildLineView(frame: CGRect) {
        let view1 = UIView(frame: frame)
        view1.backgroundColor = UIColor.colorWithCustom(230, g: 230, b: 230)
        view.addSubview(view1)
    }
    
    private func buildYellowLineView(frame: CGRect) {
        let yellowView = UIView(frame: frame)
        yellowView.backgroundColor = HENavigationYellowColor
        view.addSubview(yellowView)
    }
    
    //装饰作用的view
    private func buildDecorateView() {
        
        let lineT = [CGRectMake(0, 0, view.width, 100),
                     CGRectMake(0, 100, view.width * 0.2, view.width * 0.6),
                     CGRectMake(0, 100 + view.width * 0.6, view.width, ScreenHeight - 100 - view.width * 0.6-NavigationH),
                     CGRectMake(view.width * 0.8, 100, view.width * 0.2, view.width * 0.6)]
        for lineTFrame in lineT {
            buildTransparentView(lineTFrame)
        }
        
        let lineR = [CGRectMake(view.width * 0.2, 100, view.width * 0.6, 2),
                     CGRectMake(view.width * 0.2, 100, 2, view.width * 0.6),
                     CGRectMake(view.width * 0.8 - 2, 100, 2, view.width * 0.6),
                     CGRectMake(view.width * 0.2, 100 + view.width * 0.6, view.width * 0.6, 2)]
        
        for lineFrame in lineR {
            buildLineView(lineFrame)
        }
        
        let yellowHeight: CGFloat = 4
        let yellowWidth: CGFloat = 30
        let yellowX: CGFloat = view.width * 0.2
        let bottomY: CGFloat = 100 + view.width * 0.6
        let lineY = [CGRectMake(yellowX, 100, yellowWidth, yellowHeight),
                     CGRectMake(yellowX, 100, yellowHeight, yellowWidth),
                     CGRectMake(view.width * 0.8 - yellowHeight, 100, yellowHeight, yellowWidth),
                     CGRectMake(view.width * 0.8 - yellowWidth, 100, yellowWidth, yellowHeight),
                     CGRectMake(yellowX, bottomY - yellowHeight + 2, yellowWidth, yellowHeight),
                     CGRectMake(view.width * 0.8 - yellowWidth, bottomY - yellowHeight + 2, yellowWidth, yellowHeight),
                     CGRectMake(yellowX, bottomY - yellowWidth, yellowHeight, yellowWidth),
                     CGRectMake(view.width * 0.8 - yellowHeight, bottomY - yellowWidth, yellowHeight, yellowWidth)]
        
        for yellowRect in lineY {
            buildYellowLineView(yellowRect)
        }
    }
    
    //扫描时的动画
    private func buildAnimationLineView() {
        animationLineView.image = UIImage(named: "yellowlight")
        view.addSubview(animationLineView)
        
        timer = NSTimer(timeInterval: 2.5, target: self, selector: #selector(HEQRCodeVC.startYellowViewAnimation), userInfo: nil, repeats: true)
        timer?.tolerance = 0.25
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer!, forMode: NSRunLoopCommonModes)
        timer!.fire()
    }
    
    func startYellowViewAnimation() {
        weak var weakSelf = self
        animationLineView.frame = CGRectMake(view.width * 0.25, 100, view.width*0.5, 10)
        UIView.animateWithDuration(2.5) { () -> Void in
            weakSelf!.animationLineView.y += weakSelf!.view.width*0.55
        }
    }
}


extension HEQRCodeVC:AVCaptureMetadataOutputObjectsDelegate{
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!){
        if metadataObjects != nil && metadataObjects.count > 0{
            captureSession?.stopRunning()
            timer?.invalidate()
            let metadataObj = metadataObjects.first!
            dispatch_async(dispatch_get_main_queue(), {
                self.titleLabel.text = (metadataObj as? AVMetadataMachineReadableCodeObject)?.stringValue
            })
            
//            if metadataObj.type == AVMetadataObjectTypeQRCode{
//                 titleLabel.text = (metadataObj as? AVMetadataMachineReadableCodeObject)?.stringValue
//            }else{
//                titleLabel.text = (metadataObj as? AVMetadataMachineReadableCodeObject)?.stringValue
//            }
        }
    }
}
