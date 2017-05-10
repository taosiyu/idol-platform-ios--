//
//  Views.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

//MARK:基础自适应的collectionView
class BaseCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.bounds.size.equalTo(intrinsicContentSize) {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize{
        get{
            return self.contentSize
        }
    }
}
