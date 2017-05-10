//
//  MembersCtrCell.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

class MembersCtrCell: UICollectionViewCell {
    
    fileprivate var avator:UIImageView = {
        let vc = UIImageView()
        return vc
    }()
    
    fileprivate var nameLabel:BaseWrapLabel = {
        let label = BaseWrapLabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    fileprivate var japanLabel:BaseWrapLabel = {
        let label = BaseWrapLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.backColor
        return label
    }()
    
    fileprivate var birthLabel:BaseWrapLabel = {
        let label = BaseWrapLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.backColor
        return label
    }()
    
    fileprivate var statusLabel:BaseWrapLabel = {
        let label = BaseWrapLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.backColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.avator)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.japanLabel)
        self.contentView.addSubview(self.birthLabel)
        self.contentView.addSubview(self.statusLabel)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setModel(model:MenberModel){
        self.avator.hit_setImageWithMemberString(string: model.portrait)
        self.nameLabel.text = model.name
    }
    
    func setModelShowAll(model:MenberModel){
        self.avator.hit_setImageWithMemberString(string: model.portrait)
        self.nameLabel.text = model.name
        self.japanLabel.text = model.rome
        self.birthLabel.text = model.birthdate
        self.statusLabel.text = model.status
    }
    
    private func setupView(){
        let conV = self.contentView
        let width = self.contentView.bounds.width - 4
        var theV:UIView!
        self.avator.snp.makeConstraints { (make) in
            make.top.equalTo(conV.snp.top).offset(2)
            make.left.equalTo(conV.snp.left).offset(2)
            make.right.equalTo(conV.snp.right).offset(-2)
            make.height.equalTo(width/3*4)
        }
        theV = self.avator
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theV.snp.bottom).offset(2)
            make.left.equalTo(conV.snp.left).offset(2)
            make.right.equalTo(conV.snp.right).offset(-2)
        }
        theV = self.nameLabel

        self.japanLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theV.snp.bottom).offset(2)
            make.left.equalTo(conV.snp.left).offset(2)
            make.right.equalTo(conV.snp.right).offset(-2)
//            make.bottom.equalTo(conV.snp.bottom).offset(-2)
        }
        theV = self.japanLabel
        
        self.birthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theV.snp.bottom).offset(2)
            make.left.equalTo(conV.snp.left).offset(2)
            make.right.equalTo(conV.snp.right).offset(-2)
        }
        theV = self.birthLabel
        
        self.statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(theV.snp.bottom).offset(2)
            make.left.equalTo(conV.snp.left).offset(2)
            make.right.equalTo(conV.snp.right).offset(-2)
        }
        
    }
    
}
