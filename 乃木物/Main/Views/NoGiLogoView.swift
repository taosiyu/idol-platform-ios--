//
//  NoGiLogoView.swift
//  乃木物
//
//  Created by ncm on 2017/5/11.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

class NoGiLogoView: UIView {
    
    private var logoLeft:UIButton = {
        let btn = UIButton()
        btn.setTitle("4", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        btn.setTitleColor(UIColor.white, for: UIControlState.disabled)
        btn.setTitleColor(UIColor.mainColor, for: UIControlState.normal)
        btn.tag = 4
        return btn
    }()
    
    private var logoRight:UIButton = {
        let btn = UIButton()
        btn.setTitle("6", for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 21)
        btn.setTitleColor(UIColor.mainColor, for: UIControlState.normal)
        btn.setTitleColor(UIColor.white, for: UIControlState.disabled)
        btn.tag = 6
        return btn
    }()
    
    var clickBlock:((Int)->())?

    convenience init() {
        self.init(frame: CGRect())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setipView()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setipView(){
        self.addSubview(self.logoRight)
        self.addSubview(self.logoLeft)
        self.setRoundedCornersBy(corner: [.topRight,.bottomRight])
        
        self.logoLeft.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(55)
        }
        
        self.logoRight.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(55)
        }
        
        
        self.logoLeft.addTarget(self, action: #selector(buttonClick(btn:)), for: UIControlEvents.touchDown)
        self.logoRight.addTarget(self, action: #selector(buttonClick(btn:)), for: UIControlEvents.touchDown)
    
        setBaseButton()
    }
    
    private func setBaseButton(){
        self.logoLeft.backgroundColor = UIColor.mainColor
        self.logoRight.backgroundColor = UIColor.white
        self.logoLeft.isEnabled = false
        self.logoRight.isEnabled = true
    
    }
    
    func buttonClick(btn:UIButton){
        let tag = btn.tag
        if tag == 4{
            self.logoLeft.backgroundColor = UIColor.mainColor
            self.logoRight.backgroundColor = UIColor.white
            self.logoLeft.isEnabled = false
            self.logoRight.isEnabled = true
        }else{
            self.logoLeft.backgroundColor = UIColor.white
            self.logoRight.backgroundColor = UIColor.mainColor
            self.logoLeft.isEnabled = true
            self.logoRight.isEnabled = false
        }
        if let clo = self.clickBlock {
            clo(tag)
        }
    }

}
