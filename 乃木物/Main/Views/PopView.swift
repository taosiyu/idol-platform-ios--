//
//  PopView.swift
//  乃木物
//
//  Created by ncm on 2017/5/22.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

class PopView: UIView {

    private var labels = [BaseLabel]()
    
    private var backView:UIView = {
        let vc = UIView()
        return vc
    }()
    
    var isShow = false
    
    private var coverView:UIView = {
        let vc = UIView()
        vc.backgroundColor = UIColor.clear
        vc.isHidden = true
        return vc
    }()
    
    private var clickClosure:((Int)->())?
    
    convenience init(titles:[String],view:UIView,clickClo:@escaping ((Int)->())) {
        self.init(frame:CGRect())
        self.setupView(titles: titles)
        self.isHidden = true
        self.alpha = 0
        
        
        view.addSubview(self.coverView)
        self.coverView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(view)
        }
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(hidden))
        self.coverView.addGestureRecognizer(tap)
        self.clickClosure = clickClo
    }
    
    private func setupView(titles:[String]){
        
        self.addSubview(self.backView)
        self.backView.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(self)
        }
        self.backView.addShadowViewWithOffset(offset: 1.3)
        self.backView.backgroundColor = UIColor.black
        
        var conLabel:BaseButton?
        var index = 0
        for title in titles{
            let label = BaseButton.init()
            label.tag = index
            label.backgroundColor = UIColor.white
            label.setTitle(title, for: UIControlState.normal)
            label.setTitleColor(UIColor.black, for: UIControlState.normal)
            label.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            self.addSubview(label)
            if let baseLabel = conLabel{
                label.snp.makeConstraints({ (make) in
                    make.left.right.equalTo(self)
                    make.top.equalTo(baseLabel.snp.bottom).offset(1)
                    make.height.equalTo(50)
                })
            }else{
                label.snp.makeConstraints({ (make) in
                    make.top.left.right.equalTo(self)
                    make.height.equalTo(50)
                })
            }
            label.addTarget(self, action: #selector(btnClick(btn:)), for: UIControlEvents.touchUpInside)
            conLabel = label
            index += 1
        }
    }
    
    @objc private func btnClick(btn:BaseButton){
        if let clo = self.clickClosure {
            clo(btn.tag)
        }
    }
    
    func show(){
        self.coverView.isHidden = false
        self.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: { 
            self.alpha = 1
        }) { (finish) in
            self.isShow = true
        }
    }
    
    func hidden(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.alpha = 0
        }) { (finish) in
            self.coverView.isHidden = true
            self.isHidden = true
            self.isShow = false
        }
    }

}
