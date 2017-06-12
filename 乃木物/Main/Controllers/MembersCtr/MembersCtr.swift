//
//  MembersCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import ObjectMapper

private let cellID = "MembersCtrCellID"
class MembersCtr: BaseCtr{
    
    fileprivate var isShowAll = false
    //数据源
    private var dataSource:CollectionViewDataSource<MembersCtr>!
    
    fileprivate var sourceData = [MenberModel]()
    
    //所有的成员的信息
    fileprivate var sourceAllData = [MenberModel]()
    
    fileprivate var mainCollectionView:BaseCollectionView = {
        let layout = MembersCtrLayout()
        let vc = BaseCollectionView(frame: CGRect(), collectionViewLayout: layout)
        vc.register(MembersCtrCell.self, forCellWithReuseIdentifier: cellID)
        vc.backgroundColor = UIColor.white
        vc.showsVerticalScrollIndicator = false
        vc.showsHorizontalScrollIndicator = false
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgbColor(rgbValue: 0xdddddd)
        self.setLeftBarItem()
    }
    
    override func setupView() {
        super.setupView()
        self.view.addSubview(self.mainCollectionView)
        self.mainCollectionView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).offset(8)
            make.top.equalTo(self.view.snp.top).offset(8+64)
            make.right.equalTo(self.view.snp.right).offset(-8)
            make.bottom.equalTo(self.view.snp.bottom).offset(-8-49)
        }
//        self.mainCollectionView.addShadowViewWithOffset(offset: 1.2)
        
        self.dataSource = CollectionViewDataSource(collectionView: self.mainCollectionView, cellIdentier: cellID, delegate: self)
        
    }
    
    override func setupEvent() {
        super.setupEvent()
        self.mainCollectionView.delegate = self
    }
    
    private func changeShowType(){
        self.isShowAll = !self.isShowAll
        if self.isShowAll {
            let layout = TSYCollectionViewFlowLayout()
            self.mainCollectionView.setCollectionViewLayout(layout, animated: true)
            self.mainCollectionView.isPagingEnabled = true
            getMembersAllInfo()
        }else{
            let layout = MembersCtrLayout()
            self.mainCollectionView.setCollectionViewLayout(layout, animated: true)
            self.mainCollectionView.isPagingEnabled = false
            getMembersInfo()
        }
    }
    
    //MARK:获取成员信息(简略)
    private func getMembersInfo(){
        TSYProgressHUD.share.showLoding()
        HttpClient_Alamofire.membersSingleList(success: { (dataObjc) in
            if let models = Mapper<MenberModel>().mapArray(JSONObject: dataObjc.results){
                self.sourceData.removeAll()
                self.sourceData.append(contentsOf: models)
                self.refreshSourceData()
            }
            TSYProgressHUD.share.dissmissLoading()
        }, failed: { (error) in
            TSYProgressHUD.share.dissmissLoading()
        }) { (code, msg) in
            TSYProgressHUD.share.dissmissLoading()
        }
    }
    
    //MARK:所有的
    private func getMembersAllInfo(){
        HttpClient_Alamofire.membersAllList(success: { (dataObjc) in
            if let models = Mapper<MenberModel>().mapArray(JSONObject: dataObjc.results){
                self.sourceAllData.removeAll()
                self.sourceAllData.append(contentsOf: models)
                self.refreshSourceData()
            }
        }, failed: { (error) in
            
        }) { (code, msg) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func refreshSourceData(){
        if isShowAll {
            self.dataSource.setObjects(objs: self.sourceAllData)
            self.mainCollectionView.layoutSubviews()
            self.mainCollectionView.reloadData()
        }else{
            self.dataSource.setObjects(objs: self.sourceData)
            self.mainCollectionView.layoutSubviews()
            self.mainCollectionView.reloadData()
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        if self.sourceData.count <= 0 && !self.isShowAll {
           self.getMembersInfo()
        }else if self.sourceAllData.count <= 0 && self.isShowAll{
            let layout = TSYCollectionViewFlowLayout()
            self.mainCollectionView.setCollectionViewLayout(layout, animated: false)
            self.mainCollectionView.isPagingEnabled = true
            self.getMembersAllInfo()
        }
    }

}

extension MembersCtr:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isShowAll && self.sourceAllData.count > 0 {
            let objc = self.sourceAllData[indexPath.row]
            let vc = MemberBlogsCtr.init(model: objc)
            self.navigationController?.pushViewController(vc, animated: true)
        }else if !isShowAll && self.sourceData.count > 0{
            let objc = self.sourceData[indexPath.row]
            let vc = MemberBlogsCtr.init(model: objc)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MembersCtr:CollectionViewDataSourceDelegate{
    typealias Cell = MembersCtrCell
    typealias Object = MenberModel
    func configure(cell: MembersCtrCell, for object: MenberModel, indexPath: IndexPath) {
        if isShowAll {
            //显示全部用的方法
            cell.setModelShowAll(model: object)
        }else{
            cell.setModel(model: object)
        }
    }
}
