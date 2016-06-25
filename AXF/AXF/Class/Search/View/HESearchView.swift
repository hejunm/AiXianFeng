//
//  HESearchView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/19.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

protocol HESearchViewDelegate {
    func searchWith(keyWord:String)
}

class HESearchView: UIScrollView {
    
    var hotQueryView:HESearchKeyWordView!     //热门搜索
    var queryHistoryView:HESearchKeyWordView! //搜索历史
    var clearHistoryBtn:UIButton! //清除历史数据
    var searchDelegate:HESearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpNoti()
        initView()
        loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: private func 
    private func setUpNoti(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HESearchView.queryHistoryChanged(_:)), name: HENotiQueryHistroyChanged, object: nil)
    }
    
    /** 初始化view*/
    private func initView(){
        weak var tmpSelf = self
        //热门搜索
        hotQueryView = HESearchKeyWordView(frame: CGRectMake(0, 0, width, 0), title: "热门商品", keyWordArray: nil, searchWithKeyWord: { (keyWord) in
            HEQueryHistoryModel.shareInstance().append(keyWord) //保存数据
            tmpSelf!.searchDelegate?.searchWith(keyWord)
        })
        addSubview(hotQueryView)
        
        //搜索历史
        queryHistoryView = HESearchKeyWordView(frame: CGRectMake(0, 0, width, 0), title: "搜索历史", keyWordArray: nil, searchWithKeyWord: { (keyWord) in
            tmpSelf!.searchDelegate?.searchWith(keyWord)
        })
        addSubview(queryHistoryView)
        
        //清除历史数据btn
        clearHistoryBtn = UIButton()
        clearHistoryBtn.setTitle("清 空 历 史", forState: UIControlState.Normal)
        clearHistoryBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        clearHistoryBtn.sizeToFit()
        clearHistoryBtn.setTitleColor(UIColor.colorWithCustom(163, g: 163, b: 163), forState: UIControlState.Normal)
        clearHistoryBtn.backgroundColor = self.backgroundColor
        clearHistoryBtn.layer.cornerRadius = 5
        clearHistoryBtn.layer.borderColor = UIColor.colorWithCustom(200, g: 200, b: 200).CGColor
        clearHistoryBtn.layer.borderWidth = 0.5
        clearHistoryBtn.addTarget(self, action:#selector(HESearchView.clearQueryHistory(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(clearHistoryBtn)
    }
    
    /** 加载数据*/
    private func loadData(){
        //热门搜索
        weak var tmpSelf = self
        HEHotQueryModel.loadData { (data, error) in
            if data != nil{
                tmpSelf!.hotQueryView.keyWords = data.data?.hotquery
            }
        }
        //搜索历史
        queryHistoryChanged(nil)
    }
    
    @objc private func queryHistoryChanged(niti:NSNotification?){
        let queryHistoryArray = HEQueryHistoryModel.shareInstance().searchHistoryData
        queryHistoryView.keyWords = queryHistoryArray
        if queryHistoryArray != nil &&  queryHistoryArray!.count != 0{
            queryHistoryView.hidden = false
            clearHistoryBtn.hidden = false
            return
        }
        queryHistoryView.hidden = true
        clearHistoryBtn.hidden = true
    }
    
    func clearQueryHistory(sender:UIButton){
        HEQueryHistoryModel.shareInstance().clearQueryHistory()  
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        queryHistoryView.frame = CGRectMake(0, CGRectGetMaxY(hotQueryView.frame), width, queryHistoryView.height)
        clearHistoryBtn.frame = CGRectMake(40, CGRectGetMaxY(queryHistoryView.frame)+30, width-40*2, clearHistoryBtn.height)
        contentSize = CGSizeMake(width, CGRectGetMaxY(clearHistoryBtn.frame)+30)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}