//
//  AboutCtr.swift
//  乃木物
//
//  Created by ncm on 2017/5/12.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class AboutCtr: BaseCtr {
    
    private var image:UIImageView = {
        let vc = UIImageView()
        vc.image = UIImage.init(named: "logo46")
        return vc
    }()
    
    private var vesion:BaseWrapLabel = {
        let vc = BaseWrapLabel()
        vc.textColor = UIColor.lightGray
        vc.textAlignment = NSTextAlignment.center
        vc.text = "版本:\(AppVersion)"
        return vc
    }()
    
    private var content:BaseWrapLabel = {
        let vc = BaseWrapLabel()
        vc.textColor = UIColor.lightGray
        vc.textAlignment = NSTextAlignment.center
        vc.font = UIFont.systemFont(ofSize: 14)
        vc.text = SildeTitle
        return vc
    }()
    
    private var contentSec:BaseWrapLabel = {
        let vc = BaseWrapLabel()
        vc.textColor = UIColor.lightGray
        vc.textAlignment = NSTextAlignment.center
        vc.font = UIFont.systemFont(ofSize: 14)
        vc.text = SildeContent
        return vc
    }()
    
    private var bottomLabel:BaseWrapLabel = {
        let vc = BaseWrapLabel()
        vc.textColor = UIColor.lightGray
        vc.textAlignment = NSTextAlignment.center
        vc.text = ""
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "关于"
    }
    
    override func setupView() {
        super.setupView()
        self.view.addSubview(self.image)
        self.view.addSubview(self.vesion)
        self.view.addSubview(self.content)
        self.view.addSubview(self.contentSec)
        self.view.addSubview(self.bottomLabel)
        self.image.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(100)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.height.equalTo(100)
        }
        
        self.vesion.snp.makeConstraints { (make) in
            make.top.equalTo(self.image.snp.bottom).offset(8)
            make.left.equalTo(self.view.snp.left).offset(8)
            make.right.equalTo(self.view.snp.right).offset(-8)
        }
        
        self.content.snp.makeConstraints { (make) in
            make.top.equalTo(self.vesion.snp.bottom).offset(8)
            make.left.equalTo(self.view.snp.left).offset(8)
            make.right.equalTo(self.view.snp.right).offset(-8)
        }
        
        self.contentSec.snp.makeConstraints { (make) in
            make.top.equalTo(self.content.snp.bottom).offset(8)
            make.left.equalTo(self.view.snp.left).offset(8)
            make.right.equalTo(self.view.snp.right).offset(-8)
        }
        
        self.bottomLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-8)
            make.left.equalTo(self.view.snp.left).offset(8)
            make.right.equalTo(self.view.snp.right).offset(-8)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
