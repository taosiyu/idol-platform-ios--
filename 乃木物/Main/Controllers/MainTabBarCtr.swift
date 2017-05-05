//
//  MainTabBarCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class MainTabBarCtr: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupChildController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        
        return .portrait
    }
    
    func setupChildController(){
        
        let array = [["clsName":"ViewController","title":"home","imageName":"1"],["clsName":"ViewController","title":"home","imageName":"1"],["clsName":"ViewController","title":"home","imageName":"1"]]
        
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
        
        vc.tabBarItem.image = UIImage(named: ""+imageName)
        
        vc.tabBarItem.selectedImage = UIImage(named: ""+imageName)?.withRenderingMode(.alwaysOriginal)
        
        let nvc = UINavigationController.init(rootViewController: vc)
        
        return nvc
        
    }

}

extension MainTabBarCtr:UITabBarControllerDelegate{
    
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

