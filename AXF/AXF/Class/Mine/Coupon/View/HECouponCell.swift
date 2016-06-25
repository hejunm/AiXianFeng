//
//  HECouponCell.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/14.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HECouponCell: UITableViewCell {
    
    static let Id = "HECouponCell"
    
    let useColor = UIColor.colorWithCustom(161, g: 120, b: 90)
    let unUseColor = UIColor.colorWithCustom(158, g: 158, b: 158)
    private let  circleWidth: CGFloat = ScreenWidth * 0.16
    
    var backImageView: UIImageView? //v2_coupon_gray  v2_coupon_yellow
    var titleLabel: UILabel?
    var dateLabel: UILabel?
    var descLabel: UILabel?
    var line1View: UIView?
    var line2View: UIView?
    var circleImageView: UIImageView?
    var priceLabel: UILabel?
    var statusLabel: UILabel?
    
    var coupon: Coupon? {
        didSet {
            switch coupon!.status {
            case 0:
                setCouponCanUse(true)
                break
            case 1:
                setCouponCanUse(false)
                statusLabel?.text = "已使用"
                break
            default:
                setCouponCanUse(false)
                statusLabel?.text = "已过期"
                break
            }
            priceLabel?.text = "$" + (coupon!.value)!.cleanDecimalPointZear()
            titleLabel?.text = " " + (coupon?.name)! + "  "
            dateLabel?.text = "有效期:  " + coupon!.start_time! + "至" + coupon!.end_time!
            descLabel?.text = coupon?.desc
            setNeedsLayout()
        }
    }
    
    class func getCellFor(tableView:UITableView,couponData:Coupon)->HECouponCell{
        var cell = tableView.dequeueReusableCellWithIdentifier(Id) as? HECouponCell
        if cell == nil{
            cell = HECouponCell()
        }
        cell!.coupon = couponData
        return cell!
    }
  
    init() {
        super.init(style: .Default, reuseIdentifier: HECouponCell.Id)
        selectionStyle = UITableViewCellSelectionStyle.None
        contentView.backgroundColor = UIColor.clearColor()
        
        backImageView = UIImageView()
        contentView.addSubview(backImageView!)
        
        line1View = UIView()
        line1View?.alpha = 0.3
        contentView.addSubview(line1View!)
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFontOfSize(12)
        titleLabel?.textAlignment = NSTextAlignment.Center
        contentView.addSubview(titleLabel!)
        
        dateLabel = UILabel()
        dateLabel?.font = UIFont.systemFontOfSize(12)
        dateLabel?.textAlignment = NSTextAlignment.Center
        contentView.addSubview(dateLabel!)
        
        line2View = UIView()
        line2View?.alpha = 0.3
        contentView.addSubview(line2View!)
        
        descLabel = UILabel()
        descLabel?.font = UIFont.systemFontOfSize(9)
        descLabel?.numberOfLines = 0
        contentView.addSubview(descLabel!)
        
        circleImageView = UIImageView()
        contentView.addSubview(circleImageView!)
        
        priceLabel = UILabel(frame:CGRectMake(0, 10, circleWidth, 30))
        priceLabel?.font = UIFont.boldSystemFontOfSize(16)
        priceLabel?.textAlignment = NSTextAlignment.Center
        priceLabel?.textColor = UIColor.whiteColor()
        circleImageView!.addSubview(priceLabel!)
        
        statusLabel = UILabel(frame: CGRectMake(0, 30, circleWidth, 20))
        statusLabel!.hidden = true
        statusLabel?.textColor = UIColor.colorWithCustom(105, g: 105, b: 105)
        statusLabel?.font = UIFont.systemFontOfSize(10)
        statusLabel?.textAlignment = NSTextAlignment.Center
        circleImageView?.addSubview(statusLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let margin: CGFloat = 20
        let leftWidth: CGFloat = (width - 2 * margin) * 0.26  //左半部分宽度
        let rightWidth: CGFloat = (width - 2 * margin) * 0.74 //右半部分宽度
        let rightX = margin + leftWidth
        
        backImageView?.frame = CGRectMake(margin, 5, width - 2 * margin, height - 5*2)
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(rightX+(rightWidth - titleLabel!.width) * 0.5, 15, titleLabel!.width, titleLabel!.height)
        
        line1View?.frame = CGRectMake(rightX+10, 0, rightWidth - 20, 0.8)
        line1View?.center.y = (titleLabel?.center.y)!
        
        dateLabel?.sizeToFit()
        dateLabel?.frame = CGRectMake(rightX+(rightWidth - dateLabel!.width) * 0.5, CGRectGetMaxY(titleLabel!.frame) + 10, dateLabel!.width, dateLabel!.height)
        
        line2View?.frame = CGRectMake(rightX, CGRectGetMidY(backImageView!.frame)-0.4, rightWidth-10, 0.8)
        
        descLabel?.frame = CGRectMake(rightX + margin, CGRectGetMaxY(line2View!.frame) + 5, rightWidth - margin*2, 40)
        
        let circleX = (leftWidth - circleWidth) * 0.65
        circleImageView?.frame = CGRectMake(margin + circleX, 0, circleWidth, circleWidth)
        circleImageView?.center.y = backImageView!.center.y
    }
    
    private func setCouponCanUse(canUse: Bool) {
        backImageView!.image = canUse ? UIImage(named: "v2_coupon_yellow") : UIImage(named: "v2_coupon_gray")
        titleLabel?.textColor = canUse ? useColor : unUseColor
        titleLabel?.backgroundColor = canUse ? UIColor.colorWithCustom(255, g: 244, b: 224) : UIColor.colorWithCustom(238, g: 238, b: 238)
        dateLabel?.textColor = titleLabel?.textColor
        statusLabel?.hidden = canUse
        line1View?.backgroundColor = canUse ? useColor : unUseColor
        line2View?.backgroundColor = line1View?.backgroundColor
        descLabel?.textColor = titleLabel?.textColor
        
        let tmpView = UIView(frame: CGRectMake(0, 0, circleWidth, circleWidth))
        tmpView.backgroundColor = canUse ? HENavigationYellowColor : UIColor.colorWithCustom(210, g: 210, b: 210)
        let image = UIImage.createImageFromView(tmpView)
        circleImageView!.image = image.imageClipOvalImage()
    }
}
