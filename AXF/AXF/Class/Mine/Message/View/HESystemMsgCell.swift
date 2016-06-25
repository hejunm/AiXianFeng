//
//  HESystemMsgCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/14.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESystemMsgCell: UITableViewCell {
    
    //MARK: property
    static private let Id = "HESystemMsgCell"
  
    private var titleView: UIView?
    private var titleLabel: UILabel?
    private var showMoreButton: UIButton?
    private var subTitleView: UIView?
    private var subTitleLabel: UILabel?
    private var lineView: UIView?
    private weak var tableView: UITableView?
    var message: HEMessage? {
        didSet {
            if message == nil {return}
            titleLabel?.text = message!.title
            subTitleLabel?.attributedText = message?.content?.getAttStr()
            
            if  message!.normalCellHeight >= message!.selectedCellHeight{
                subTitleLabel?.numberOfLines = 1
                showMoreButton?.hidden = true
            }else{
                subTitleLabel?.numberOfLines = 0
                showMoreButton?.hidden = false
            }
        }
    }
    
    class func getCell(tableView: UITableView) -> HESystemMsgCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Id) as? HESystemMsgCell
        if cell == nil {
            cell = HESystemMsgCell(style: UITableViewCellStyle.Default, reuseIdentifier: Id)
        }
        cell?.tableView = tableView
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleView?.frame = CGRectMake(0, 0, width, 60)
        titleLabel?.frame = CGRectMake(20, 0, width-20-80-20, 60)
        showMoreButton?.frame = CGRectMake(width - 80, 15, 60, 30)
        lineView?.frame = CGRectMake(20, 59, width - 20, 1)
        
        let subTitleViewH = height-60-20
        subTitleView?.frame = CGRectMake(0, 60, width, subTitleViewH)
        subTitleLabel?.frame = CGRectMake(20, 10, width - 20*2, subTitleViewH - 10*2)
    }
    
    private func initView(){
        backgroundColor = UIColor.clearColor()
        selectionStyle = UITableViewCellSelectionStyle.None
        contentView.backgroundColor = UIColor.clearColor()
        
        titleView = UIView()
        titleView!.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(titleView!)
        
        titleLabel = UILabel()
        titleLabel?.numberOfLines = 0
        titleLabel!.textAlignment = NSTextAlignment.Left
        titleLabel!.font = UIFont.systemFontOfSize(15)
        titleView!.addSubview(titleLabel!)
        
        showMoreButton = UIButton(type: .Custom)
        showMoreButton!.setTitle("显示全部", forState: .Normal)
        showMoreButton!.titleLabel!.font = UIFont.systemFontOfSize(13)
        showMoreButton?.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        showMoreButton?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        showMoreButton!.titleLabel?.textAlignment = NSTextAlignment.Center
        showMoreButton!.addTarget(self, action: #selector(HESystemMsgCell.showMoreButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        showMoreButton?.hidden = true
        titleView!.addSubview(showMoreButton!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.lightGrayColor()
        lineView?.alpha = 0.2
        titleView?.addSubview(lineView!)
        
        subTitleView = UIView()
        subTitleView!.backgroundColor = UIColor.whiteColor()
        contentView.addSubview(subTitleView!)
        
        subTitleLabel = UILabel()
        subTitleLabel?.numberOfLines = 0
        subTitleLabel!.textAlignment = NSTextAlignment.Left
        subTitleLabel?.backgroundColor = UIColor.clearColor()
        subTitleLabel!.textColor = UIColor.lightGrayColor()
        subTitleLabel!.font = UIFont.systemFontOfSize(12)
        subTitleView!.addSubview(subTitleLabel!)
    }
    
    func showMoreButtonClick(sender:UIButton){
        message!.isSelected = !message!.isSelected
        tableView?.reloadData()
    }
}
