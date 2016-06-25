//
//  HEMineHelpDetailVC.swift
//  AXF
//
//  Created by 贺俊孟 on 16/6/15.
//  Copyright © 2016年 贺俊孟. All rights reserved.
//

import UIKit

class HEMineHelpDetailVC: HEBaseViewController {

    /// 问题答案tableView
    private weak var qAtableView:UITableView!
    /// 问题答案模型
    private var qAModels:[HEQuestion]!{
        didSet{
            qAtableView.reloadData()
        }
    }
    /// 上次选中的section
    private var lastSelecedSection:Int = -1
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "常见问题"
        buildTableView()
        loadData()
    }
    
    private func buildTableView(){
        let tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.height -= NavigationH
        tableView.sectionHeaderHeight = 50
        tableView.backgroundColor = HEGlobalBackgroundColor
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HeHelpQuestionHeaderView.self, forHeaderFooterViewReuseIdentifier: HeHelpQuestionHeaderView.Id)
        view.addSubview(tableView)
        qAtableView = tableView
    }
    
    private func loadData(){
        weak var tmpSelf = self
        HEQuestion.loadData { (data, error) in
            if data != nil{
                tmpSelf!.qAModels = data
            }
        }
    }
    
    private func headerClick(section:Int){
        if lastSelecedSection != -1{
            if lastSelecedSection != section{ //删除前一个展开的，添加当前展开的
                qAModels![lastSelecedSection].isSelected = false
                (qAtableView.headerViewForSection(lastSelecedSection) as? HeHelpQuestionHeaderView)?.isSelected = false
                qAModels![section].isSelected = true
                (qAtableView.headerViewForSection(section) as? HeHelpQuestionHeaderView)?.isSelected = true
                
                qAtableView.beginUpdates()
                qAtableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: lastSelecedSection)], withRowAnimation: .Top)
                lastSelecedSection = section
                qAtableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: section)], withRowAnimation: .Top)
                qAtableView.endUpdates()
            }else{ //删除现在的
                qAModels![section].isSelected = false
                (qAtableView.headerViewForSection(section) as? HeHelpQuestionHeaderView)?.isSelected = false
                
                lastSelecedSection = -1
                qAtableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: section)], withRowAnimation: .Top)
            }
        }else{
            qAModels![section].isSelected = true
            (qAtableView.headerViewForSection(section) as? HeHelpQuestionHeaderView)?.isSelected = true
            
            lastSelecedSection = section
            qAtableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: section)], withRowAnimation: .Top)
        }
    }
}

extension HEMineHelpDetailVC:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return qAModels?.count ?? 0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastSelecedSection == section{
            return 1
        }
        return 0
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier(HeHelpQuestionHeaderView.Id) as! HeHelpQuestionHeaderView
        headerView.question = qAModels[section]
        weak var temSelf = self
        headerView.selectedBlock = {
            temSelf!.headerClick(section)
        }
        return headerView
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let questionModel = qAModels[indexPath.section]
        let cell = HEHelpAnswerCell.getCell(tableView, question: questionModel)
        return cell
    }
}

extension HEMineHelpDetailVC:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == lastSelecedSection{
            let questionModel = qAModels[indexPath.section]
            return questionModel.cellHeight
        }
        return 0
    }
}