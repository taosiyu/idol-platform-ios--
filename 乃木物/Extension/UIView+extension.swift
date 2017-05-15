//
//  UIView+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

let UIViewKey = "UIViewKey"
extension UIView {
    
    //MARK:自定义内容
    @discardableResult
    func addTapCallBack(callBack: VoidClosure) -> UITapGestureRecognizer {
        let ges = UITapGestureRecognizer()
        addGestureRecognizer(ges)
        objc_setAssociatedObject(self, UIViewKey, callBack, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        ges.addTarget(self, action: #selector(callBackBegin))
        return ges
    }
    func callBackBegin(){
        if let clo = objc_getAssociatedObject(self, UIViewKey) as? VoidClosure{
            clo()
        }
    }
    
    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func moveToFront() {
        self.superview?.bringSubview(toFront: self)
    }
    
    func backToView(){
        self.superview?.sendSubview(toBack: self)
    }
    
    //MARK:绘制定制的图形
    func createSanJiao(size:CGSize) {
        
        let pathR = UIBezierPath(rect: self.bounds)
        pathR.lineWidth = 0.5
        let layerR = CAShapeLayer()
        layerR.path = pathR.cgPath
        layerR.strokeColor = UIColor.mainColor.cgColor
        layerR.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layerR)
    }
    
    //MARK:添加边框间距
    func addEdesLayout(superView:UIView,offSize:CGFloat=0){
        let conV = self
        conV.snp.makeConstraints { (make) in
            make.left.equalTo(superView.snp.left).offset(8)
            make.top.equalTo(superView.snp.top).offset(8+offSize)
            make.right.equalTo(superView.snp.right).offset(-8)
            make.bottom.equalTo(superView.snp.bottom).offset(-8)
        }
    }
    
    //MARK:添加阴影
    func addShadowViewWithOffset(offset: CGFloat,color:UIColor=UIColor.black){
        var conV: UIView!
        conV = self.superview
        var view: UIView!
        view = nil
        
        let shadowView = UIView()
        shadowView.backgroundColor = UIColor.white
        view = shadowView
        
        let radius = self.layer.cornerRadius
        view.layer.cornerRadius = radius
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = 0.33
        view.layer.shadowOffset = CGSize(width:0, height:offset)
        view.layer.shadowRadius = offset
        conV.insertSubview(shadowView, belowSubview: self)
        view.snp.makeConstraints { (make) in make.edges.equalTo(self) }
    }
    
    //MARK:试图加边框
    func setBorder(){
        let width = (ScreenWidth - 40)/3
        let bound = CGRect(x: 0, y: 0, width: width, height: width)
        let borderPath = UIBezierPath.init(rect: bound)
        let borderLayer = CAShapeLayer()
        borderLayer.path = borderPath.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.rgbColor(rgbValue: 0xd4237a).cgColor;
        borderLayer.lineWidth = 1
        borderLayer.frame = bound
        self.layer.addSublayer(borderLayer)
    }
    
    //MARK:设置圆角
    func setRoundedCorners() {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width:20,height:20))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

}
