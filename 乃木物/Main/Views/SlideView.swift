//
//  SlideView.swift
//  乃木物
//
//  Created by ncm on 2017/5/12.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

private let width = ScreenWidth/3*2
class SlideView: UITableView {
    
    private var isOut = false
    
    private var canAnimation = true
    
    private let restAlpha:CGFloat = 0.6
    
    private var superView:UIView = UIView.init()
    
    var slideScrollClo:((Bool)->())?
    
    private var coverView:UIView = {
        let vc = UIView()
        vc.backgroundColor = UIColor.black
        vc.alpha = 0
        vc.isHidden = true
        return vc
    }()
    
    private var headView:UIView = {
        let vc = UIView()
        return vc
    }()

    convenience init(superView:UIView) {
        let frame = CGRect(x: -width, y: 0, width: width, height: superView.bounds.height)
        self.init(frame:frame)
        self.setupView()
        //添加遮盖
        superView.addSubview(self.coverView)
        self.coverView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(superView)
        }
        self.superView = superView
        self.addPanGestureRecognizer()
        self.toFront()
    }
    
    func toFront(){
        self.coverView.moveToFront()
        self.moveToFront()
    }
    
    private func setupView(){
        self.tableFooterView = UIView.init()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(beginAnimation))
        self.coverView.addGestureRecognizer(tap)
    }
    
    //MARK:添加滑动手势
    private func addPanGestureRecognizer(){
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(pan:)))
        pan.delegate = self
        self.superView.addGestureRecognizer(pan)
    }
    
    private var isFromLeft = false
    private var isFromRight = false
    @objc private func panGesture(pan:UIPanGestureRecognizer){
        if let ctr = MainApp.window?.rootViewController as? MainTabBarCtr{
           if ctr.childViewControllers[0].childViewControllers.count > 1{
                return
           }else if ctr.childViewControllers[1].childViewControllers.count > 1 {
                return
           }else if ctr.childViewControllers[2].childViewControllers.count > 1 {
                return
            }
        }
        let status = pan.state
        let translation = pan.translation(in: self.superView)
        let startXPoint = pan.location(in: self.superView).x
        switch status {
        case .began:
            if startXPoint < 30 && !isOut{
                isFromLeft = true
            }else if isOut && startXPoint > width{
                isFromRight = true
            }
            break
        case .changed:
            if isFromLeft{
                self.panDistance(distance: translation.x)
            }else if isFromRight{
                self.panDistanceFromRight(distance: translation.x)
            }
            break
        case .ended,.cancelled:
            if isFromLeft {
                isFromLeft = false
                self.panEnd(distance: translation.x)
            }else if isFromRight {
                isFromRight = false
                self.panEnd(distance: translation.x)
            }
            break
        default:
            break
        }
    }
    
    //MARK:滑动时候的动画    Left->Rigth
    private func panDistance(distance:CGFloat){
        if distance >= width{return}
        self.toFront()
        self.coverView.isHidden = false
        self.transform = CGAffineTransform.init(translationX: distance, y: 0)
        let alphaFloat = (distance/width)*restAlpha
        self.coverView.alpha = alphaFloat
        if let clo = self.slideScrollClo{
            clo(false)
        }
    }
    
    //MARK:滑动时候的动画    Right->Left
    private func panDistanceFromRight(distance:CGFloat){
        if self.transform.tx <= 0{return}
        let disW = width-abs(distance)
        self.transform = CGAffineTransform(translationX: disW, y: 0)
        let alphaFloat = (disW/width)*restAlpha
        self.coverView.alpha = alphaFloat
    }
    
    //MARK:松手时的动画
    private func panEnd(distance:CGFloat){
        if !self.canAnimation {return}
        let w = width*0.5
        self.canAnimation = false
        if distance > w || (width-abs(distance)) > w{
            self.startAnimation()
        }else{
            self.endAnimation()
        }
        if let clo = self.slideScrollClo{
            clo(true)
        }
    }
    
    //MARK:开始动画
    private func startAnimation(){
        self.toFront()
        self.coverView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {[unowned self] in
            self.coverView.alpha = self.restAlpha
            self.transform = CGAffineTransform.init(translationX: width, y: 0)
        }) { (finish) in
            self.isOut = true
            self.canAnimation = true
        }
    }
    
    func beginAnimation(){
        if self.canAnimation {
            self.canAnimation = false
            self.isOut = !self.isOut
            if isOut {
                startAnimation()
            }else{
                endAnimation()
            }
        }
    }
    
    //MARK:结束动画
    private func endAnimation(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {[unowned self] in
            self.coverView.alpha = 0
            self.transform = CGAffineTransform.identity
        }) { (finish) in
            self.isOut = false
            self.coverView.isHidden = true
            self.canAnimation = true
        }
        if let clo = self.slideScrollClo{
            clo(true)
        }
    }

}

extension SlideView:UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer.view is UIScrollView {
            return false
        }
        return true
    }
}



