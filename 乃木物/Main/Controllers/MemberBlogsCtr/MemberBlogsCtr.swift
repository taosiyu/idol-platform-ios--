//
//  MemberBlogsCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/11.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import ObjectMapper

private let cellID = "MemberBlogsCellID"
class MemberBlogsCtr: BaseCtr {
    
    private var memberModel = ModelFactory.new(type: MenberModel.self)
    //数据源
    private var dataSource:TableViewDataSource<MemberBlogsCtr>!
    
    fileprivate var sourceData = [BlogModel]()
    
    fileprivate var dataListTableView:RefreshView = {
        let vc = RefreshView.init()
        vc.rowHeight = 85
//        vc.rowHeight = UITableViewAutomaticDimension
        vc.register(MemberBlogsCell.self, forCellReuseIdentifier: cellID)
        return vc
    }()
    
    init(model:MenberModel) {
        self.memberModel = model
        super.init(nibName: nil, bundle: nil)
        self.getMemberBlogsDetail()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.memberModel.name
        self.dataListTableView.headerBeginRefreshing()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setupView() {
        super.setupView()
        self.setupTableView()
        self.view.backgroundColor = UIColor.rgbColor(rgbValue: 0xdddddd)
    }
    
    //MARK:tableView的初始化
    private func setupTableView(){
        
        self.view.addSubview(self.dataListTableView)
        
        self.dataListTableView.addShadowViewWithOffset(offset: 1.5)
        
        self.dataListTableView.delegate = self
        
        dataSource = TableViewDataSource(tableView: self.dataListTableView, cellIdentier: cellID, delegate: self,type:TableViewDataSourceType.row)
        
        self.dataListTableView.setHeaderRefreshClosure {[unowned self] (_) in
            self.getMemberBlogsDetail()
        }
        
        self.dataListTableView.setFooterRefreshClosure {[unowned self] (_) in
            self.getMemberBlogsDetail(isFoot: true)
        }
        
        self.dataListTableView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(8)
            make.top.equalTo(self.view.snp.top).offset(8+64)
            make.right.equalTo(self.view.snp.right).offset(-8)
            make.bottom.equalTo(self.view.snp.bottom).offset(-8)
        }
        
    }
    
    //MARK:加载博客数据
    private func getMemberBlogsDetail(isFoot:Bool=false){
        var dic = Eic()
        dic["member"] = memberModel.rome as AnyObject?
        dic["page"] = self.dataListTableView.refreshCount as AnyObject?
        HttpClient_Alamofire.memberBlogs(params: dic, success: { (dataObjc) in
            if let models = Mapper<BlogModel>().mapArray(JSONObject: dataObjc.results) {
                if !isFoot {
                    self.sourceData.removeAll()
                    self.sourceData.append(contentsOf: models)
                    self.dataListTableView.nowCount = models.count
                    self.refreshSourceData()
                }else{
                    self.sourceData.append(contentsOf: models)
                    self.dataListTableView.nowCount = models.count
                    self.refreshSourceData()
                }
            }
            self.dataListTableView.endRefreshing()
        }, failed: { (error) in
            self.dataListTableView.endRefreshing()
        }) { (code, msg) in
            self.dataListTableView.endRefreshing()
        }
    }
    
    //MARK:刷新数据源
    private func refreshSourceData(){
        self.dataSource.setObjects(objs: self.sourceData)
    }

}

extension BlogModel:TableModelDelegate,MainViewModel{}

extension MemberBlogsCtr:TableViewDataSourceDelegate{
    typealias Cell = MemberBlogsCell
    typealias Object = BlogModel
    func configure(cell: MemberBlogsCell, for object: BlogModel, indexPath: IndexPath) {
        cell.setCellModel(model: object)
    }
}

extension MemberBlogsCtr:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objc = self.sourceData[indexPath.row]
        let vc = WKWebViewController.init(blogModel: objc)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
