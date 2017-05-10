//
//  NewsListCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/8.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import ObjectMapper

private let cellID = "DataListCellID"
private let cellOneID = "DataListCellOneID"

class NewsListCtr: BaseCtr {

    //数据源
    private var dataSource:TableViewTwoCellDataSource<NewsListCtr>!
    
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
            make.top.bottom.left.right.equalTo(self.view)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:加载全部数据
    fileprivate func getDataListInfo(isFoot:Bool=false){
        //下拉
        var dic = Eic()
        dic["page"] = self.dataListTableView.refreshCount as AnyObject?
        if !isFoot {
            HttpClient_Alamofire.newsList(params: dic, success: { (dataObjc) in
                self.dataListTableView.endRefreshing()
                if let models = Mapper<DataListModel>().mapArray(JSONObject: dataObjc.results){
                    self.sourceData.removeAll()
                    self.sourceData.append(contentsOf: models)
                    self.dataListTableView.nowCount = models.count
                    self.refreshSourceData()
                }
            }, failed: { (err) in
                self.dataListTableView.endRefreshing()
            }, errorClo: { (code, msg) in
                self.dataListTableView.endRefreshing()
            })
        }else{
            HttpClient_Alamofire.newsList(params: dic, success: { (dataObjc) in
                self.dataListTableView.endRefreshing()
                if let models = Mapper<DataListModel>().mapArray(JSONObject: dataObjc.results){
                    self.sourceData.append(contentsOf: models)
                    self.dataListTableView.nowCount = models.count
                    self.refreshSourceData()
                }
                
            }, failed: { (err) in
                self.dataListTableView.endRefreshing()
            }, errorClo: { (code, msg) in
                self.dataListTableView.endRefreshing()
            })
        }
        
    }
    
    //MARK:刷新数据源
    private func refreshSourceData(){
        self.dataSource.setObjects(objs: self.sourceData)
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if self.sourceData.count <= 0{
            self.dataListTableView.headerBeginRefreshing()
        }
    }
    
}

extension NewsListCtr:TableViewDataTwoCellSourceDelegate{
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

extension NewsListCtr:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.sourceData[indexPath.row]
        if let ctr = self.parent as? TitlesSelectTabbarCtr{
            ctr.pushNewCtr(model: model)
        }
    }
}
