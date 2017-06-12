//
//  HitWebImageManager.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import YYWebImage

extension UIImageView{

    func hit_setImageWithString(string: String) {
        if string.isEmpty{
            image = UIImage.init(named: "logo46")
            return
        }
        let width = (ScreenWidth - 40)/3
       yy_setImage(with: string.fixImgUrl, placeholder: UIImage.init(named: "logo46"), options: YYWebImageOptions.progressive, progress: { (pro,end) in
       }, transform: { (yyimage, url) -> UIImage? in
        self.image = yyimage.yy_imageByResize(to: CGSize(width: width, height: width), contentMode: UIViewContentMode.scaleAspectFill)
        return self.image
       }, completion: nil)
    }
    
    func hit_setImageWithMemberString(string: String) {
        yy_setImage(with: string.fixImgUrl, placeholder: nil, options: YYWebImageOptions.progressive, progress: { (pro,end) in
        }, transform: { (yyimage, url) -> UIImage? in
            self.image = yyimage.yy_imageByResize(to: CGSize(width: 640, height: 960), contentMode: UIViewContentMode.scaleAspectFit)
            return self.image
        }, completion: nil)
    }
    
    func hit_normalImage(string:String){
        yy_setImage(with: string.fixImgUrl, options: YYWebImageOptions.allowBackgroundTask)
    }

}
