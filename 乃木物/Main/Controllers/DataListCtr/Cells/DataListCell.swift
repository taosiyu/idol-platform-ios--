//
//  DataListCell.swift
//  乃木物
//
//  Created by ncm on 2017/5/8.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

class DataListCell: UITableViewCell {
    
    private var titleLabel:BaseWrapLabel = {
        let label = BaseWrapLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private var contentLabel:BaseWrapLabel = {
        let label = BaseWrapLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private lazy var imageOne:UIImageView = {
        let vc = UIImageView.init()
        vc.contentMode = .scaleAspectFill
        vc.clipsToBounds = true
        return vc
    }()
    
    private lazy var imageTwo:UIImageView = {
        let vc = UIImageView.init()
        vc.contentMode = .scaleAspectFill
        vc.clipsToBounds = true
        return vc
    }()
    
    private lazy var imageThree:UIImageView = {
        let vc = UIImageView.init()
        vc.contentMode = .scaleAspectFill
        vc.clipsToBounds = true
        return vc
    }()
    
    private var timeLabel:BaseLabel = {
        let label = BaseLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private var zimuLabel:BaseLabel = {
        let label = BaseLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.zimuLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.imageOne)
        self.contentView.addSubview(self.imageTwo)
        self.contentView.addSubview(self.imageThree)
        
        self.cellinit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellinit(){
        
        let conV = self.contentView
        
        let width = (ScreenWidth - 40)/3
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(conV.snp.top).offset(10)
            make.left.equalTo(conV.snp.left).offset(10)
            make.right.equalTo(conV.snp.right).offset(-10)
        }
        
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.equalTo(conV.snp.left).offset(10)
            make.right.equalTo(conV.snp.right).offset(-10)
        }
        
        self.imageOne.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentLabel.snp.bottom).offset(8)
            make.width.height.equalTo(width)
            make.left.equalTo(conV.snp.left).offset(10)
        }
        
        self.imageTwo.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageOne)
            make.width.height.equalTo(width)
            make.left.equalTo(self.imageOne.snp.right).offset(10)
        }
        
        self.imageThree.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageOne)
            make.width.height.equalTo(width)
            make.left.equalTo(self.imageTwo.snp.right).offset(10)
        }
        
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageThree.snp.bottom).offset(8)
            make.left.equalTo(conV.snp.left).offset(8)
            make.bottom.equalTo(conV.snp.bottom).offset(-8)
        }
        
        self.zimuLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.timeLabel)
            make.left.equalTo(self.timeLabel.snp.right).offset(10)
            make.right.equalTo(conV.snp.right).offset(-10)
        }
        
    }
    
    func setCellModel(model:DataListModel){
        self.titleLabel.text = model.title
        self.timeLabel.text = model.timeStr
        self.contentLabel.text = model.summary
        self.zimuLabel.text = model.provider
        if let image = model.withpic.first?.image {
            self.imageOne.hit_setImageWithString(string: image)
        }
        if model.withpic.count >= 2 {
            self.imageTwo.hit_setImageWithString(string: model.withpic[1].image)
        }
        if let image = model.withpic.last?.image {
            self.imageThree.hit_setImageWithString(string:image)
        }
    }

}
