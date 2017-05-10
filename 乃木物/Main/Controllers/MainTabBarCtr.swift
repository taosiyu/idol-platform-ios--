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
        
        self.tabBar.backgroundImage = UIImage.imageWithColor(color: UIColor.init(white: 1, alpha: 0.4))
        
        self.delegate = self

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
        
        let array = [["clsName":"TitlesSelectTabbarCtr","title":"乃木物","imageName":"home_Icon"],["clsName":"MembersCtr","title":"官博","imageName":"blog_Icon"],["clsName":"ViewController","title":"我的","imageName":"my_Icon"]]
        
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

