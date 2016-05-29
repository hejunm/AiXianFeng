//
//  HESuperMarketHeaderView.swift
//  AXF
//
//  Created by 贺俊孟 on 16/5/27.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HESuperMarketHeaderView: UITableViewHeaderFooterView {
   
    static let Id = "HESuperMarketHeaderViewId"
    
    private lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.textColor = UIColor.colorWithCustom(100, g: 100, b: 100)
        titleLabel.textAlignment = NSTextAlignment.Left
        return titleLabel
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func getHeaderViewFor(tableView tableView:UITableView)->HESuperMarketHeaderView{
        var headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(Id) as?HESuperMarketHeaderView
        if headerView == nil{
            headerView  = HESuperMarketHeaderView(reuseIdentifier: Id)
        }
        return headerView!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRectMake(HEMargin_10, 0, width-HEMargin_10, height)
    }
    
    func setTitle(title:String?){
        titleLabel.text = title ?? ""
    }
}
