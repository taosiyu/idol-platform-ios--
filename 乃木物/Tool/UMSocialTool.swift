//
//  UMSocialTool.swift
//  乃木物
//
//  Created by ncm on 2017/5/15.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class UMSocialTool: NSObject {
    //MARK:友盟分享UI
    static func share(backClo:@escaping ((UMSocialPlatformType)->())){
        UMSocialUIManager.setPreDefinePlatforms([UMSocialPlatformType.QQ])
        UMSocialUIManager.showShareMenuViewInWindow { (platformType, userInfo) in
            //QQ分享
            if platformType == UMSocialPlatformType.QQ{
                backClo(UMSocialPlatformType.QQ)
            }
        }
    }
    
    //MARK:QQ分享
    static func shareQQ(url:String,ctr:UIViewController){
        let messageObjc = UMSocialMessageObject()
        
        let thumbURL = "https://mobile.umeng.com/images/pic/home/social/img-1.png"
        
        let shareObject = UMShareWebpageObject.shareObject(withTitle: "欢迎使用【友盟+】社会化组件U-Share", descr: "欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！", thumImage: thumbURL)
        
        //设置网页地址
        shareObject?.webpageUrl = "http://mobile.umeng.com/social"
        
        //分享消息对象设置分享内容对象
        messageObjc.shareObject = shareObject
        
        UMSocialManager.default().share(to: UMSocialPlatformType.QQ, messageObject: messageObjc, currentViewController: ctr) { (data, error) in
            if ((error) != nil) {
                print("************Share fail with error \(error)*********")
            }else{
                if let resp = data as? UMSocialShareResponse {
                    //分享结果消息
                    print("response message is \(resp.message)");
                    //第三方原始返回的数据
                    print("response originalResponse data is \(resp.originalResponse)")
                    
                }else{
                    print("response data is \(data)")
                }
            }
            HitMessage.showErrorWithMessage(message: "分享错误")
        }

    }
}
