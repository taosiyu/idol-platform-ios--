//
//  MembersCtrLayout.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class MembersCtrLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        let width = (ScreenWidth - 31.CF)/2
        let height = width/3*4
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 5
        self.itemSize = CGSize(width:width,height:height+20)
//        estimatedItemSize
    }
}
