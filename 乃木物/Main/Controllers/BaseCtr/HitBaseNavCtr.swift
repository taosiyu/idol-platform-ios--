//
//  HitBaseNavCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class HitBaseNavCtr: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tintColor = UIColor.black
        
        self.interactivePopGestureRecognizer?.isEnabled = true
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "icon_back_black"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        }
        
        super.pushViewController(viewController, animated: true)
    }
    
    @objc private func back(){
        self.popViewController(animated: true)
    }

}
