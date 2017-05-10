//
//  UIView+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    
    func removeAllSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func moveToFront() {
        self.superview?.bringSubview(toFront: self)
    }
    
    func createSanJiao(str:String,size:CGSize) {
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.beginPath()
            ctx.move(to: CGPoint(x: 0, y: size.height))
            ctx.addLine(to: CGPoint(x: size.width, y: size.height))
            ctx.addLine(to: CGPoint(x: size.width, y: 0))
            ctx.setLineWidth(1)
            ctx.setFillColor(UIColor.mainColor.cgColor)
            ctx.fillPath()
            ctx.strokePath()
        }
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
        print(self.bounds)
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
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width:30,height:30))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }

}
