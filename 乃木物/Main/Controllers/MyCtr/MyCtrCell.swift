//
//  MyCtrCell.swift
//  乃木物
//
//  Created by ncm on 2017/5/12.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class MyCtrCell: UITableViewCell {
    
    private lazy var backView:UIView = {
        let vc = UIView.init()
        return vc
    }()
    
    private lazy var imageOne:UIImageView = {
        let vc = UIImageView.init()
        vc.clipsToBounds = true
        return vc
    }()
    
    private var titleLabel:BaseLabel = {
        let label = BaseWrapLabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.contentView.addSubview(self.backView)
        self.backView.addSubview(self.titleLabel)
        self.backView.addSubview(self.imageOne)
        self.backView.addShadowViewWithOffset(offset: 1.3)
        
        let conV = self.contentView
        
        self.backView.snp.makeConstraints { (make) in
            make.top.left.equalTo(conV).offset(2)
            make.bottom.right.equalTo(conV).offset(-2)
        }
        
        self.imageOne.snp.makeConstraints { (make) in
            make.left.equalTo(self.backView.snp.left).offset(8)
            make.centerY.equalTo(self.backView.snp.centerY)
            make.width.height.equalTo(30)
        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageOne.snp.left).offset(12)
            make.centerY.equalTo(self.backView.snp.centerY)
        }
    }
    
    func setCellBy(dic:[String:String]){
        self.titleLabel.text = dic["title"]
        if let image = dic["image"]{
            self.imageOne.image = UIImage.init(named: image)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
