//
//  BaseCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/7.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class BaseCtr: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false

        self.setupView()
        
        self.setupEvent()
        
    }
    
    func setLeftBarItem(title:String){
        let item = UIBarButtonItem.init(image: UIImage.init(named:"menu"), style: UIBarButtonItemStyle.done, target: self, action: nil)
        let items = UIBarButtonItem.init(title: title, style: UIBarButtonItemStyle.done, target: self, action: nil)
        items.isEnabled = false
        self.navigationItem.leftBarButtonItems = [item,items]
    }
    
    func setupView(){
        
        
    }
    
    func setupEvent(){
        
    }
    
    deinit {
        dLog("\(self) deinited")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func mySystem(){
        
    }
    
    
}
