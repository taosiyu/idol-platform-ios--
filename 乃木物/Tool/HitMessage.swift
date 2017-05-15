//
//  HitMessage.swift
//  NewChama
//
//  Created by Levi on 16/4/18.
//  Copyright © 2016年 com.NewChama. All rights reserved.
//

import SVProgressHUD

/// 用于显示的工具
class HitMessage: NSObject {
    static func resetDismissDuration() {
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
    
    static func showProgress(progress: Float,status: String){
        SVProgressHUD.showProgress(progress, status: status)
    }

    static func showLoading() {
        SVProgressHUD.showInfo(withStatus: "请稍候...")
    }

    static func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    static func dismissWithDefaultDelay(){
        SVProgressHUD.dismiss(withDelay: 2)
    }

    static func showNetErrorMessage() {
        SVProgressHUD.showError(withStatus: "网络连接失败，请检查网络")
    }

    static func showWithMessage(message: String) {
        SVProgressHUD.show(withStatus: fixMsg4message(message: message, placeHolderMsg: "请稍候..."))
    }

    static func showInfoWithMessage(message: String) {
        SVProgressHUD.showInfo(withStatus: fixMsg4message(message: message, placeHolderMsg: "操作失败！"))
    }

    static func showErrorWithMessage(message: String) {
        SVProgressHUD.showError(withStatus: fixMsg4message(message: message, placeHolderMsg: "操作失败！"))
    }

    static func showSuccessWithMessage(message: String) {
        SVProgressHUD.showSuccess(withStatus: fixMsg4message(message: message, placeHolderMsg: "操作成功！"))
    }

    static func fixMsg4message(message: String, placeHolderMsg: String) -> String {
        if message.isEmpty {
            return placeHolderMsg
        }
        return message
    }
    
    static func showMessageWithDefaultInterval(message:String){
        SVProgressHUD.showError(withStatus: message)
    }
    
}
