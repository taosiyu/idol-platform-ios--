//
//  TSYCollectionViewFlowLayout.swift
//  TSYCollectionViewWithLayout
//
//  Created by ncm on 2017/2/28.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

class TSYCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        
        self.minimumLineSpacing = 2
        self.minimumInteritemSpacing = 2
        self.itemSize = CGSize(width: ScreenWidth-20, height: ScreenHeight-64-49-8)
        self.scrollDirection = .horizontal
    }
    
    //MARK:delegate
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //获得super已经计算好的布局属性 只有线性布局才能使用
        let array = super.layoutAttributesForElements(in: rect)
        //计算CollectionView最中心的x值
        guard let collectVC = self.collectionView else {
            return array
        }
        let centerX = collectVC.contentOffset.x + collectVC.frame.size.width/2
        for value in array! {
            let delta = value.center.x - centerX
            let scale = 1 - delta/collectVC.frame.size.width
//            let t = scale*CGFloat(M_PI_2)
//            value.transform = CGAffineTransform(rotationAngle: t)
//            let al = abs(scale)
//            value.transform = CGAffineTransform.init(scaleX: scale, y: scale)
//            value.alpha = al
        }
        return array
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}




