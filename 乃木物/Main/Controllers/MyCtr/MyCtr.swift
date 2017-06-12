//
//  MyCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/12.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class MyCtr: BaseCtr {
    
    fileprivate let titlesAndImages = [["title":"设置","image":""],["title":"关于","image":""]]
    
    private var headTableView:HeadChangeTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLeftBarItem()
    }
    
    override func setupView() {
        super.setupView()
        self.headTableView = HeadChangeTableView.init()
        self.headTableView.delegate = self
        self.headTableView.dataSource = self
        self.headTableView.register(MyCtrCell.self, forCellReuseIdentifier: cellID)
        self.headTableView.rowHeight = 50
        self.view.addSubview(self.headTableView)
        self.headTableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.snp.top).offset(64)
            make.bottom.equalTo(self.view.snp.bottom).offset(-49)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

private let cellID = "MyCtrCellID"
extension MyCtr:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titlesAndImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MyCtrCell
        let dic = self.titlesAndImages[indexPath.row]
        cell.setCellBy(dic: dic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            SVProgressHUD.dismiss(withDelay: 1)
            SVProgressHUD.showInfo(withStatus: "正在开发中")
        }else{
            let vc = AboutCtr()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}




