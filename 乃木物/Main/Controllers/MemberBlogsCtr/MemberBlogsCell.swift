//
//  MemberBlogsCell.swift
//  乃木物
//
//  Created by ncm on 2017/5/11.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class MemberBlogsCell: UITableViewCell {
    
    private var nameLabel:BaseWrapLabel = {
        let label = BaseWrapLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
    private var timeLabel:BaseLabel = {
        let label = BaseLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private var titleLabel:BaseWrapLabel = {
        let label = BaseWrapLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.timeLabel)
        self.contentView.addSubview(self.nameLabel)
        
        self.cellinit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellinit(){
        let conV = self.contentView
        
        self.timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(conV.snp.top).offset(8)
            make.left.equalTo(conV.snp.left).offset(8)
            make.right.equalTo(conV.snp.right).offset(-8)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.timeLabel.snp.bottom).offset(8)
            make.left.equalTo(conV.snp.left).offset(8)
            make.right.equalTo(conV.snp.right).offset(-8)
        }
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(conV.snp.bottom).offset(-8)
            make.left.equalTo(conV.snp.left).offset(8)
            make.right.equalTo(conV.snp.right).offset(-8)
        }
        
    }
    
    func setCellModel(model:BlogModel){
        self.nameLabel.text = model.author
        self.timeLabel.text = model.timeStr
        self.titleLabel.text = model.title
    }

}
