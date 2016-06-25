//
//  HESearchKeyWordView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/24.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//  用于显示搜索关键字

import UIKit

class HESearchKeyWordView: UIView {

    private let titleLablel = UILabel()
    
    /// 根据关键字进行搜索的回调
    private var searchWithKeyWord:((String)->())?
    
    /// 关键字数组
    var keyWords:[String]!{
        didSet{
            addKeyWordsBtn()  //将关键字添加到view上面
        }
    }
  
    //MARK: life cycle
    convenience init(frame:CGRect, title:String,keyWordArray:[String]?,searchWithKeyWord:(String)->()){
        self.init(frame:frame)
        
        titleLablel.font = UIFont.systemFontOfSize(15)
        titleLablel.textColor = UIColor.colorWithCustom(140, g: 140, b: 140)
        titleLablel.text = title
        addSubview(titleLablel)
        
        self.searchWithKeyWord = searchWithKeyWord
        keyWords = keyWordArray
        addKeyWordsBtn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let btnH: CGFloat = 30
        let btnPadding: CGFloat = 30
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        
        var btnW: CGFloat = 0
        var lastX: CGFloat = marginX
        var lastY: CGFloat = marginY
        
        subviews.forEach { (subView) in
            if subView == titleLablel{
                subView.frame = CGRectMake(lastX, lastY, width-marginX*2, 35)
                lastY = CGRectGetMaxY(subView.frame) + marginY
            }else{ //UIButton
                btnW = ((subView as! UIButton).titleLabel?.width)! + btnPadding
                if width - lastX > btnW{
                    subView.frame = CGRectMake(lastX, lastY, btnW, btnH)
                }else{
                    lastY = lastY+btnH+marginY
                    lastX = marginX
                    subView.frame = CGRectMake(lastX, lastY, btnW, btnH)
                }
                lastX  = lastX+btnW+marginX
            }
        }
        if subviews.count == 1{
            height = lastY
        }else{
            height = lastY + btnH + marginY
        }
        superview?.setNeedsLayout()
    }
    
    //MARK: private func
    private func addKeyWordsBtn(){
        subviews.forEach { (subView) in
            if subView.isMemberOfClass(UIButton){
                subView.removeFromSuperview()
            }
        }
        if keyWords == nil || keyWords.count == 0 {return}
        for keyWord in keyWords{
            let btn = UIButton()
            btn.setTitle(keyWord, forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = UIColor.whiteColor()
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = 15
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColor.colorWithCustom(200, g: 200, b: 200).CGColor
            btn.addTarget(self, action: #selector(HESearchKeyWordView.searchBtnClick(_:)), forControlEvents: .TouchUpInside)
            addSubview(btn)
        }
    }
    
    @objc private func searchBtnClick(seader:UIButton){
        if searchWithKeyWord == nil {return}
        searchWithKeyWord!(seader.titleForState(.Normal)!)
    }
}
