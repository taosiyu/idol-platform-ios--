//
//  MainTabBarCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

private let cellID = "sideViewCellID"
private let headCellID = "sideViewHeadID"
class MainTabBarCtr: UITabBarController {
    
    fileprivate let first = [["title":"收藏","image":""],["title":"清除缓存","image":""],["title":"设置","image":""]]
    
    fileprivate let second = [["title":"分享","image":""],["title":"关于","image":""]]
    
    fileprivate let headTitles = ["","交流"]
    
    //MARK:侧边栏
    private var sideView:SlideView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundImage = UIImage.imageWithColor(color: UIColor.init(white: 1, alpha: 0.4))
        
        self.delegate = self
        self.setupChildController()
        self.setSlideView()
    }
    
    private func setSlideView(){
        self.sideView = SlideView.init(superView: self.view)
        self.sideView .backgroundColor = UIColor.white
        self.sideView.register(MyCtrCell.self, forCellReuseIdentifier: cellID)
        self.sideView.register(MyHeadView.self, forHeaderFooterViewReuseIdentifier: headCellID)
        self.sideView.rowHeight = 50
        self.sideView.delegate = self
        self.sideView.dataSource = self
        let vc = headView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 160))
        self.sideView.tableHeaderView = vc
        self.view.addSubview(sideView)
    }
    
    func animationBegin(){
        self.sideView.beginAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    func setupChildController(){
        
        let array = [["clsName":"TitlesSelectTabbarCtr","title":"乃木物","imageName":"home_Icon"],["clsName":"MembersCtr","title":"官博","imageName":"blog_Icon"],["clsName":"MyCtr","title":"我的","imageName":"my_Icon"]]
        
        var arrayVC = [UIViewController]()
        for dict in array{
            
            arrayVC.append(controller(dict: dict))
        }
        viewControllers = arrayVC
        
    }
    
    /// 字典创建控制器
    ///
    /// - Parameter dict: 包含所有试图的字典
    /// - Returns: 一个试图
    private func controller(dict:[String:String])->UIViewController{
        
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.namespace+"."+clsName) as? UIViewController.Type else {
                
                return UIViewController()
        }
        
        let vc = cls.init()
        vc.title = title
        
        vc.tabBarItem.image = UIImage(named:imageName+"_normal")
        vc.tabBarItem.selectedImage = UIImage(named:imageName)?.withRenderingMode(.alwaysOriginal)
        //字体颜色
        let dic = [NSForegroundColorAttributeName:UIColor.rgbColor(rgbValue: 0xd4237a)]
        vc.tabBarItem.setTitleTextAttributes(dic, for: UIControlState.selected)
        
        let nvc = HitBaseNavCtr.init(rootViewController: vc)
        
        return nvc
        
    }

}

extension MainTabBarCtr:UITabBarControllerDelegate{
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        //获取控制器索引
        let inx = (childViewControllers as NSArray).index(of: viewController)
        
        //判断点按的按钮是哪一个试图的
        
        if selectedIndex == 0 && inx == selectedIndex {
            print("点击了首页")
        }
        
        return !viewController.isMember(of: UIViewController.self)
    }
}

//MARK:tableview-Delegate=Datasource
extension MainTabBarCtr:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return self.first.count
        }else{
            return self.second.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let vc = tableView.dequeueReusableHeaderFooterView(withIdentifier: headCellID) as? MyHeadView {
            print(self.headTitles[section])
            vc.setTitle(str: self.headTitles[section])
            return vc
        }
        let width = ScreenWidth/3*2
        let vc = MyHeadView.init(reuseIdentifier: headCellID)
        vc.frame = CGRect(x: 0, y: 0, width: width, height: 45)
        vc.setTitle(str: self.headTitles[section])
        print(self.headTitles[section])
        return vc
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MyCtrCell
        if indexPath.section == 0{
            let dic = self.first[indexPath.row]
            cell.setCellBy(dic: dic)
        }else{
            let dic = self.second[indexPath.row]
            cell.setCellBy(dic: dic)
        }
        return cell
    }
}

import SnapKit

class headView:UIView {
    
    private var backView:UIView = {
        let vc = UIView()
        vc.backgroundColor = UIColor.mainColor
        return vc
    }()
    
    private var headImage:UIImageView = {
        let headImage = UIImageView()
        headImage.image = UIImage.init(named: "logo46")
        return headImage
    }()
    
    private var titleLabel:BaseLabel = {
        let label = BaseLabel()
        label.textColor = UIColor.white
        label.text = SildeTitle
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private var contentLabel:BaseWrapLabel = {
        let label = BaseWrapLabel()
        label.textColor = UIColor.lightGray
        label.text = SildeContent
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.addSubview(backView)
        self.backView.addSubview(headImage)
        self.backView.addSubview(titleLabel)
        self.backView.addSubview(contentLabel)
        let conV = self.backView
        self.backView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(18)
            make.left.equalTo(self.snp.left).offset(8)
            make.bottom.right.equalTo(self).offset(-8)
        }
        self.backView.addShadowViewWithOffset(offset: 1.3)
        self.headImage.snp.makeConstraints { (make) in
            make.top.equalTo(conV.snp.top).offset(28)
            make.left.equalTo(conV.snp.left).offset(8)
            make.width.height.equalTo(50)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conV.snp.left).offset(8)
            make.top.equalTo(self.headImage.snp.bottom).offset(2)
        }
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(conV.snp.left).offset(8)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(2)
            make.right.equalTo(conV.snp.right).offset(-8)
        }
        self.setLayout(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout(frame:CGRect){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: frame.width, y: frame.height)
        gradient.colors = [UIColor.mainColor,UIColor.mainColor,UIColor.white]
        self.layer.addSublayer(gradient)
    }
}



//MARK:每个section的head
class MyHeadView:UITableViewHeaderFooterView{
    
    private var back:UIView = {
        let vc = UIView.init()
        vc.backgroundColor = UIColor.white
        return vc
    }()
    
    private var title:UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.mainColor
        self.addSubview(self.back)
        self.addSubview(self.title)
        self.back.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).offset(-1)
        }
        self.title.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.back.snp.centerY)
            make.left.equalTo(self.back.snp.left).offset(8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(str:String){
        self.title.text = str
    }
    
}
