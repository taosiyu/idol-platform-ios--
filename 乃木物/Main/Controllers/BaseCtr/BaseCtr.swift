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
    
}
