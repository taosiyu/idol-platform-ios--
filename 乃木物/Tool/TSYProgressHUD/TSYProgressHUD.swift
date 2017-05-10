//
//  TSYProgressHUD.swift
//  乃木物
//
//  Created by ncm on 2017/5/9.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class TSYProgressHUD: NSObject {
    
    static let share:TSYProgressHUD = TSYProgressHUD()
    
    var isCanTouch = true
    
    //MAKR:获取window
    private lazy var fontWindow:UIWindow? = {
        let windows = UIApplication.shared.windows
        for w in windows {
            let windowOnMainScreen = w.screen == UIScreen.main
            let windowIsVisible = (!w.isHidden&&w.alpha > 0)
            let windowLevelSupported = w.windowLevel >= UIWindowLevelNormal
            if windowOnMainScreen && windowIsVisible && windowLevelSupported{
                return w
            }
        }
        return nil
    }()
    
    private lazy var controlView:UIControl = {
        let con = UIControl.init()
        con.isUserInteractionEnabled = self.isCanTouch
        con.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        con.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        con.backgroundColor = UIColor.clear
        return con
    }()
    
    private lazy var hubView:UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let hub = UIVisualEffectView.init(effect: blur)
        hub.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        hub.autoresizingMask = [UIViewAutoresizing.flexibleBottomMargin,UIViewAutoresizing.flexibleLeftMargin,UIViewAutoresizing.flexibleTopMargin,UIViewAutoresizing.flexibleRightMargin]
        return hub
    }()
    
    private lazy var baseView:UIImageView = {
        let vc = UIImageView()
        vc.image = UIImage.imageWithColor(color: UIColor.black).blurImageWithLevel(level: 0.7)
        vc.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return vc
    }()
    
    private lazy var loadingView:TSYCircleLoading = {
        let vc = TSYCircleLoading.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        vc.backgroundColor = UIColor.clear
        return vc
    }()
    
    private lazy var showView:UIView = {
        let vc = UIView()
        vc.backgroundColor = UIColor.clear
        vc.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        vc.setRoundedCorners()
        vc.addSubview(self.baseView)
        vc.addSubview(self.loadingView)
        self.loadingView.center = vc.center
        self.loadingView.startAnimation()
        return vc
    }()
    
    //MARK:显示加载
    func showLoding(){
        if let window = self.fontWindow{
            ThreadTool.main {[unowned self] in
                window.addSubview(self.controlView)
                window.addSubview(self.showView)
                self.showView.center = window.center
                self.controlView.moveToFront()
                self.showView.moveToFront()
            }
            
        }
        
    }
    
    func dissmissLoading(){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveEaseOut, animations: {[unowned self] in
            self.showView.transform = CGAffineTransform.init(scaleX: 0.001, y: 0.001)
        }) {[unowned self] (finish) in
            self.controlView.removeFromSuperview()
            self.loadingView.endAnimation()
            self.baseView.removeFromSuperview()
            self.showView.removeFromSuperview()
            self.showView.transform = CGAffineTransform.identity
        }
    }

}
