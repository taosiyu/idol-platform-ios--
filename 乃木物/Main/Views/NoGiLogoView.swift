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

    private var logo46:UILabel = {
        let label = UILabel()
        label.text = "46"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    var clickBlock:VoidClosure?
    
    private var isChange = true
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setipView()
        self.backgroundColor = UIColor.mainColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setipView(){
        self.addSubview(self.logo46)
        self.logo46.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
            
        }
        let ges = UITapGestureRecognizer()
        addGestureRecognizer(ges)
        ges.addTarget(self, action: #selector(beginAnimation))
    }
    
    func beginAnimation(){
        if isChange{
            isChange = false
            if let clo = self.clickBlock {
                clo()
            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseInOut, animations: {[unowned self] in
                self.logo46.transform = CGAffineTransform.init(rotationAngle: CGFloat(M_PI_4))
            }) { (finish) in
                self.isChange = true
                self.logo46.transform = CGAffineTransform.identity
            }
        }
    }

}
