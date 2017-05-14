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
    @objc private func panGesture(pan:UIPanGestureRecognizer){
        if isFromLeft {return}
        let status = pan.state
        let translation = pan.translation(in: self.superView)
        switch status {
        case .began:
            let startXPoint = pan.location(in: self.superView).x
            if startXPoint < 20{
                isFromLeft = true
            }
            break
        case .changed:
            if isFromLeft{
                print("translation.x=\(translation.x)")
            }
            break
        case .ended:
            break
        default:
            break
        }
    }
    
    
    //MARK:开始动画
    private func startAnimation(){
        self.coverView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {[unowned self] in
            self.coverView.alpha = self.restAlpha
            self.transform = CGAffineTransform.init(translationX: width, y: 0)
        }) { (finish) in
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
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseIn, animations: {[unowned self] in
            self.coverView.alpha = 0
            self.transform = CGAffineTransform.identity
        }) { (finish) in
            self.coverView.isHidden = true
            self.canAnimation = true
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



