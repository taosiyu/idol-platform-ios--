//
//  HeadChangeTableView.swift
//  乃木物
//
//  Created by ncm on 2017/5/12.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class HeadChangeTableView: UITableView {

    private lazy var headView:UIView = {
        let vc = UIView()
        vc.backgroundColor = UIColor.clear
        vc.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 150)
        vc.alpha = 0.6
        let label = UILabel()
        label.text = "4 6"
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 30)
        label.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        label.center = vc.center
        vc.addSubview(label)
        return vc
    }()

    convenience init() {
        self.init(frame: CGRect(), style: UITableViewStyle.plain)
        setupView()
        self.separatorStyle = .none
    }
    
    var myContext:NSObject!
    private func setupView(){
//        self.tableHeaderView = self.headView
        self.tableFooterView = UIView()
        addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: &myContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &myContext {
            if let newValue = change?[NSKeyValueChangeKey.newKey] {
                if let yy = newValue as? CGPoint{
                    
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "contentOffset.y", context: &myContext)
    }

}
