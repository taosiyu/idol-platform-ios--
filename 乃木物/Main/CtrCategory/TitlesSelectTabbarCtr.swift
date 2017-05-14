//
//  TitlesSelectTabbarCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/7.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class TitlesSelectTabbarCtr: UIViewController {
    
    fileprivate var mainScrollView:UIScrollView = {
        let vc = UIScrollView.init()
        vc.backgroundColor = UIColor.white
        vc.isPagingEnabled = true
        vc.bounces = false
        vc.showsVerticalScrollIndicator = false
        vc.showsHorizontalScrollIndicator = false
        return vc
    }()
    
    fileprivate var titlesTabbar:TitlesTabbar!
    
    fileprivate var controllers = ["DataListCtr","BlogListCtr","NewsListCtr","MagazineListCtr"]
    
    fileprivate var titles = ["全部","博客","新闻","杂志"]
    
    
    convenience init(ctrs:[String],titles:[String]) {
        self.init()
        self.controllers = ctrs
        self.titles = titles
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setupViews()
        self.setupCtrs()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setLeftBarItem()
    }
    
    func setLeftBarItem(){
        let item = UIBarButtonItem.init(image: UIImage.init(named:"menu"), style: UIBarButtonItemStyle.done, target: self, action: #selector(slideInOut))
        self.navigationItem.leftBarButtonItem = item
    }
    
    @objc private func slideInOut(){
        if let ctr = MainApp.window?.rootViewController as? MainTabBarCtr {
            ctr.animationBegin()
        }
    }
    
    //MSRK:设置顶部的按钮tabber
    fileprivate func setupViews(){
        self.titlesTabbar = TitlesTabbar.init(titles: self.titles)
        self.view.addSubview(self.titlesTabbar)
        self.titlesTabbar.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: 40)
        self.titlesTabbar.showBottomLine()
        self.titlesTabbar.setBeginButton(index: 0)
        
        //buttonClick
        self.titlesTabbar.buttonClick = {[unowned self] (index) in
            self.changeScrollViewShowView(index:index)
        }
        
        //ScrollView
        let y = self.titlesTabbar.frame.origin.y + self.titlesTabbar.frame.height
        self.mainScrollView.frame = CGRect(x: 0, y: y, width: ScreenWidth, height: ScreenHeight - y - 49)
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.contentSize = CGSize(width: self.titles.count.CF*ScreenWidth, height: 0)
        self.mainScrollView.delegate = self
        
    }
    //MARK:改变显示试图的位置
    
    fileprivate func changeScrollViewShowView(index:Int){
        if let ctr = self.childViewControllers[index] as? BaseCtr {
            ctr.didMove(toParentViewController: self)
        }
        let x = self.mainScrollView.bounds.width*index.CF
        UIView.animate(withDuration: 0.2) {[unowned self] in
            self.mainScrollView.contentOffset = CGPoint(x: x, y: 0)
        }
    }

    //MARK:添加ctr和view
    fileprivate func setupCtrs(){
        for (index,ctr) in self.controllers.enumerated() {
            if ctr.isEmpty{
                
            }else{
                if let cls = NSClassFromString(Bundle.main.namespace+"."+ctr) as? UIViewController.Type{
                    let vc = cls.init()
                    self.addCtrAndViews(ctr: vc, index: index)
                }
            }
        }
    }
    
    //MARK:添加试图和ctr
    fileprivate func addCtrAndViews(ctr:UIViewController,index:Int){
        self.addChildViewController(ctr)
        let conV = self.mainScrollView
        let x = ScreenWidth * index.CF
        self.mainScrollView.addSubview(ctr.view)
        ctr.view.frame = CGRect(x: x, y: 0, width: conV.bounds.width, height: conV.bounds.height)
    }
    
//    fileprivate func changeControllerFromOldControllerToNew(old:UIViewController,new:UIViewController){
//        self.addChildViewController(new)
//        
//        self.transition(from: old, to: new, duration: 0.3, options: UIViewAnimationOptions.curveEaseIn, animations: { 
//            
//        }) { (finished) in
//            if finished {
//                new.didMove(toParentViewController: self)
//                old.willMove(toParentViewController: nil)
//                old.removeFromParentViewController()
//                currentVC = new
//            }else{
//                currentVC = old
//            }
//        }
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension TitlesSelectTabbarCtr:UIScrollViewDelegate{
    
    fileprivate func scrollViewChange(index:Int,present:CGFloat){
        self.titlesTabbar.setButtonLine(index: index, present: present)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = (scrollView.contentOffset.x/ScreenWidth).I
        let old = index*ScreenWidth.I
        let distance = (scrollView.contentOffset.x - old.CF)/ScreenWidth
        self.scrollViewChange(index: index, present: distance)
    }
    
}


//MARK:整体的跳转

import ObjectMapper
extension TitlesSelectTabbarCtr{
    
    func pushNewCtr(model:DataListModel){
        let vc = WKWebViewController.init(urlStr: "", title: model.title, model: model)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}











