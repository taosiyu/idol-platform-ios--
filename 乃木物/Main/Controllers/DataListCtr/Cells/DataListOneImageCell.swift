//
//  DataListOneImageCell.swift
//  乃木物
//
//  Created by ncm on 2017/5/9.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

class DataListOneImageCell: UITableViewCell {

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
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.contentLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.zimuLabel)
        self.contentView.addSubview(self.imageOne)
        self.titleLabel.backgroundColor = UIColor.white
        self.contentLabel.backgroundColor = UIColor.white
        self.timeLabel.backgroundColor = UIColor.white
        self.zimuLabel.backgroundColor = UIColor.white
        self.imageOne.backgroundColor = UIColor.white
        
        self.cellinit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellinit(){
        
        let conV = self.contentView
        
        let width = (ScreenWidth - 40)/3
        
        self.imageOne.snp.makeConstraints { (make) in
            make.top.equalTo(conV.snp.top).offset(10)
            make.width.height.equalTo(width)
            make.right.equalTo(conV.snp.right).offset(-10)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(conV.snp.top).offset(10)
            make.left.equalTo(conV.snp.left).offset(10)
            make.right.equalTo(self.imageOne.snp.left).offset(-10)
        }
        
        self.contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            make.left.equalTo(conV.snp.left).offset(10)
            make.right.equalTo(self.titleLabel.snp.right)
        }
        
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(self.imageOne.snp.bottom).offset(8)
            make.top.greaterThanOrEqualTo(self.contentLabel.snp.bottom).offset(8)
            make.left.equalTo(conV.snp.left).offset(8)
            make.bottom.equalTo(conV.snp.bottom).offset(-8)
        }
        
        self.zimuLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.timeLabel)
            make.left.equalTo(self.timeLabel.snp.right).offset(10)
            make.right.lessThanOrEqualTo(conV.snp.right).offset(-10)
        }
        
    }
    
    func setCellModel(model:DataListModel){
        self.titleLabel.text = model.title
        self.contentLabel.text = model.summary
        self.timeLabel.text = model.timeStr
        self.zimuLabel.text = model.provider
        if let image = model.withpic.first?.image {
            self.imageOne.hit_setImageWithString(string: image)
            self.imageOne.isHidden = false
            self.titleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(10)
                make.left.equalTo(self.contentView.snp.left).offset(10)
                make.right.equalTo(self.imageOne.snp.left).offset(-10)
            }
            self.timeLabel.snp.remakeConstraints { (make) in
                make.top.greaterThanOrEqualTo(self.imageOne.snp.bottom).offset(8)
                make.top.greaterThanOrEqualTo(self.contentLabel.snp.bottom).offset(8)
                make.left.equalTo(self.contentView.snp.left).offset(8)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
            }
        }else{
            self.imageOne.image = nil
            self.imageOne.isHidden = true
            self.timeLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentLabel.snp.bottom).offset(8)
                make.left.equalTo(self.contentView.snp.left).offset(8)
                make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
            }
            self.titleLabel.snp.remakeConstraints { (make) in
                make.top.equalTo(self.contentView.snp.top).offset(10)
                make.left.equalTo(self.contentView.snp.left).offset(10)
                make.right.equalTo(self.contentView.snp.right).offset(-10)
            }
        }
    }


}
