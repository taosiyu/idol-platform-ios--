//
//  SaveCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/15.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import ObjectMapper

private let cellID = "SaveCellID"
private let cellOneID = "SaveCellOneID"

class SaveCtr: BaseCtr {

    //数据源
    private var dataSource:TableViewTwoCellDataSource<SaveCtr>!
    
    fileprivate var sourceData = [DataListModel]()
    
    fileprivate var dataListTableView:RefreshView = {
        let vc = RefreshView.init()
        vc.estimatedRowHeight = 85
        vc.rowHeight = UITableViewAutomaticDimension
        vc.register(DataListCell.self, forCellReuseIdentifier: cellID)
        vc.register(DataListOneImageCell.self, forCellReuseIdentifier: cellOneID)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        self.dataListTableView.headerBeginRefreshing()
    }
    
    override func setupView() {
        super.setupView()
        self.setupTableView()
    }
    
    //MARK:tableView的初始化
    private func setupTableView(){
        
        self.view.addSubview(self.dataListTableView)
        
        self.dataListTableView.delegate = self
        
        dataSource = TableViewTwoCellDataSource(tableView: self.dataListTableView, cellIdentier: cellID,cellIdentierTwo: cellOneID, delegate: self,type:TableViewDataSourceType.row,changeTwoCellKey:"isThreeImage")
        
        self.dataListTableView.setHeaderRefreshClosure {[unowned self] (_) in
            self.getDataListInfo()
        }
        
        self.dataListTableView.setFooterRefreshClosure {[unowned self] (_) in
            self.getDataListInfo(isFoot: true)
        }
        
        self.dataListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:加载全部数据
    fileprivate func getDataListInfo(isFoot:Bool=false){
        
        if !isFoot {
            RainSQLiteQuery.getRows(tableName: SQLTableView, filter: "", order: "id DESC", limitFrom: 0, to: 10, finishClo: { [unowned self] (models) in
                self.dataListTableView.endRefreshing()
                self.sourceData.removeAll()
                self.sourceData.append(contentsOf: models)
                self.dataListTableView.nowCount = models.count
                self.refreshSourceData()
            })
        }else{
            let from = (self.dataListTableView.refreshCount-1)*10
            let to = (self.dataListTableView.refreshCount)*10
            RainSQLiteQuery.getRows(tableName: SQLTableView, filter: "", order: "id DESC", limitFrom: from, to: to, finishClo: {[unowned self] (models) in
                self.dataListTableView.endRefreshing()
                self.sourceData.append(contentsOf: models)
                self.dataListTableView.nowCount = models.count
                self.refreshSourceData()
            })
        }
    }
    
    //MARK:刷新数据源
    private func refreshSourceData(){
        self.dataSource.setObjects(objs: self.sourceData)
    }
    
}

extension SaveCtr:TableViewDataTwoCellSourceDelegate{
    typealias Cell = DataListCell
    typealias CellTwo = DataListOneImageCell
    typealias Object = DataListModel
    func configure(cell: DataListCell, for object: DataListModel, indexPath: IndexPath) {
        cell.setCellModel(model: object)
    }
    func configureTwo(cell: DataListOneImageCell, for object: DataListModel, indexPath: IndexPath) {
        cell.setCellModel(model: object)
    }
}

extension SaveCtr:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.sourceData[indexPath.row]
        let vc = WKWebViewController.init(urlStr: "", title: model.title, model: model)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



