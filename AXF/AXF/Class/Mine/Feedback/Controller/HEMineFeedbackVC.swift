//
//  HEMineFeedbackVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/8.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  意见反馈。

import UIKit

class HEMineFeedbackVC: HEBaseViewController {

    private weak var promptLabel:UILabel!
    private weak var iderTextView:HEPlaceHolderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavi()
        initView()
    }
    
    private func initNavi(){
        navigationItem.title = "意见反馈"
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton("提交", titleColor: UIColor.colorWithCustom(100, g: 100, b: 100), target: self, action: #selector(HEMineFeedbackVC.updataBtnClick))
    }
    
    private func initView(){
        
        view.backgroundColor = HEGlobalBackgroundColor
        let margin:CGFloat = 15
        
        let label = UILabel(frame: CGRectMake(margin, 5, view.width - 2 * margin, 50))
        label.text = "你的批评和建议能帮助我们更好的完善产品,请留下你的宝贵意见!"
        label.numberOfLines = 2;
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(15)
        view.addSubview(label)
        promptLabel = label
        
        let textView = HEPlaceHolderTextView(frame: CGRectMake(margin, CGRectGetMaxY(promptLabel.frame) + 10, ScreenWidth - 2 * margin, 150))
        textView.placeholder = "请输入宝贵意见(300字以内)"
        view.addSubview(textView)
        iderTextView = textView
    }
    
    func updataBtnClick(){
        if iderTextView.text == nil || 0 == iderTextView.text?.characters.count {
            ProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入意见,心里空空的")
        } else if iderTextView.text?.characters.count < 5 {
            ProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "请输入超过5个字啊亲~")
        } else if iderTextView.text?.characters.count >= 300 {
            ProgressHUD.showImage(UIImage(named: "v2_orderSuccess")!, status: "说的太多了,臣妾做不到啊~")
        } else {
            ProgressHUD.showWithStatus("发送中")
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
            dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                ProgressHUD.showSuccessWithStatus("已经收到你的意见了,我们会用心改正的,放心吧~~")
            })
            
            let time2 = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(time2, dispatch_get_main_queue(), { () -> Void in
                ProgressHUD.dismiss()
                self.navigationController?.popViewControllerAnimated(true)
            })
        }
    }
}