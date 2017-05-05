//
//  HitWebImageManager.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import SDWebImage

extension UIImageView{

    func hit_setImageWithString(string: String) {
        sd_setImage(with: string.fixImgUrl, placeholderImage: UIImage.init())
    }

}
