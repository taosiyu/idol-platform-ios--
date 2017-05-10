//
//  TSYCircleLoading.swift
//  TSYCirclePercentageVIew
//
//  Created by ncm on 2016/12/28.
//  Copyright © 2016年 ncm. All rights reserved.
//

import UIKit

//MARK:******* 圆开始角度 *******
let TCircleStartAngle   = CGFloat.init(-M_PI - M_PI_2)
let TCircleEndAngle     = CGFloat.init(M_PI_2)

class TSYCircleLoading: UIView {
    
    private lazy var circle = CAShapeLayer.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupVC()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupVC() {
        self.circle.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        let path = UIBezierPath.init(ovalIn: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)).cgPath
        self.circle.path               = path
        self.circle.position           = CGPoint(x:frame.width/2,y:frame.height/2)
        self.circle.fillColor          = UIColor.clear.cgColor
        self.circle.strokeColor        = UIColor.white.cgColor
        self.circle.lineCap            = kCALineCapRound
        self.circle.lineWidth          = 2
        self.circle.shouldRasterize    = true
        self.circle.rasterizationScale = 2 * UIScreen.main.scale
        layer.addSublayer(circle)
    }
    
    func startAnimation() {
       
        self.circle.removeAllAnimations()
        let drawAnimation      = CABasicAnimation.init(keyPath: "strokeEnd")
        drawAnimation.repeatCount = 1
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1
        drawAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)

        let drawAnimation2      = CABasicAnimation.init(keyPath: "strokeStart")
        drawAnimation2.repeatCount = 1
        drawAnimation2.fromValue = -1
        drawAnimation2.toValue = 1
        drawAnimation2.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        
        let drawRotation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        drawRotation.fromValue = 0-M_PI_4+(M_PI_4)*0.2
        drawRotation.repeatCount = 1
        drawRotation.toValue = M_PI_4-M_2_PI-M_PI_4
        drawRotation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)

        let group = CAAnimationGroup()
        group.duration = 1
        group.repeatCount = 9999
        group.animations = [drawAnimation2,drawAnimation,drawRotation]
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        self.circle.add(group, forKey: "group")
    }
    
    func endAnimation(){
        self.circle.removeAllAnimations()
        self.removeFromSuperview()
    }

}
