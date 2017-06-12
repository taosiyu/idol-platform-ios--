//
//  AppDelegate.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        HitMessage.resetDismissDuration()
        
        //友盟
        self.umengSetting()
        
        //SQLite
        self.setSQlite()
        
        //bugfly
        Bugly.start(withAppId: "e3fad653ab")
        
        //进入主页面
        self.mainTabBarView()
        
        return true
    }
    
    //MARK:创建本地数据库
    private func setSQlite(){
        RainSQLiteDB.shared.createTable(sqlParam: "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,detailId VARCHAR(40) NOT NULL,timeStr VARCHAR(20), title TEXT,provider TEXT,summary TEXT, images TEXT", tableName:SQLTableView)
    }
    
    //MARK:友盟设置
    private func umengSetting(){
        //打开log
        UMSocialManager.default().openLog(true)
        
        UMSocialManager.default().umSocialAppkey = UMENGAPPKEY
        
        //QQ分享
//        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: QQAPIKEY, appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
        
        //微博
//        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: SINAAPIKEY, appSecret: "54f59ab29164c09328f937a5be42b087", redirectURL: "https://sns.whalecloud.com/sina2/callback")
        
        //微信
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: WEIXIN, appSecret: WEIXINAPPSECRET, redirectURL: "http://mobile.umeng.com/social")
        
    }
    
    private func mainTabBarView(){
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let ctr = MainTabBarCtr()

        window?.rootViewController = ctr
        
        window?.makeKeyAndVisible()
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let result = UMSocialManager.default().handleOpen(url, options: options)
        return result
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        let result = UMSocialManager.default().handleOpen(url)
        return result
    }


}

