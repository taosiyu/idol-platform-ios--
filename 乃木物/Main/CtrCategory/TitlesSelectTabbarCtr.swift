//
//  TitlesSelectTabbarCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/7.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

protocol TitlesSelectTabbarCtrDelegate {
    func beginRefresh()
}

class TitlesSelectTabbarCtr: UIViewController {
    
    fileprivate var mainScrollView:UIScrollView = {
        let vc = UIScrollView.init()
        vc.backgroundColor = UIColor.white
        vc.isPagingEnabled = true
        return vc
    }()
    
    fileprivate var titlesTabbar:TitlesTabbar!
    
    fileprivate var controllers = [TitlesSelectTabbarCtrDelegate]()
    
    fileprivate var titles = [String]()
    
    
    convenience init(ctrs:[TitlesSelectTabbarCtrDelegate],titles:[String]) {
        self.init()
        self.controllers = ctrs
        self.titles = titles
        self.setupViews()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MSRK:设置顶部的按钮tabber
    fileprivate func setupViews(){
        self.titlesTabbar = TitlesTabbar.init(titles: self.titles)
        self.view.addSubview(self.titlesTabbar)
        self.titlesTabbar.frame = CGRect(x: 0, y: 64, width: ScreenWidth, height: 35)
        
        //ScrollView
        let y = self.titlesTabbar.frame.origin.y + self.titlesTabbar.frame.height
        self.mainScrollView.frame = CGRect(x: 0, y: y, width: ScreenWidth, height: ScreenHeight - y)
        self.view.addSubview(self.mainScrollView)
        self.mainScrollView.contentSize = CGSize(width: self.titles.count.CF, height: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
