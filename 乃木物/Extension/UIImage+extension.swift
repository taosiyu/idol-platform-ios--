//
//  UIImage+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import CoreImage

extension UIImage {
    
    //颜色转图片
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x:0, y:0, width:1, height:1);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!;
    }
    
    //颜色转图片2
    class func imageByColor(color:UIColor,size:CGSize)->UIImage?{
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        UIGraphicsEndImageContext()
        return nil
    }
    
    //MARK:模糊图片
    func blurImageWithLevel(level: CGFloat) -> UIImage {
        
        guard let inputImg = CIImage.init(image: self) else {
            return self
        }
        //创建高斯模糊滤镜
        guard let filter = CIFilter(name: "CIGaussianBlur") else {
            return self
        }
        
        filter.setValue(inputImg, forKey: kCIInputImageKey)
        filter.setValue(level, forKey: "inputRadius")
        
        guard let outputImg = filter.outputImage else {
            return self
        }
        //生成模糊图片
        let context = CIContext(options: nil)
        let theCgImg = context.createCGImage(outputImg, from: inputImg.extent)
        
        return UIImage.init(cgImage: theCgImg!)
    }
    
    func compressImage(width: CGFloat) -> UIImage {
        let maxWidth = width;
        let maxHeight = self.size.height;
        var newImageSize = self.size;
        if (self.size.width > maxWidth) {
            newImageSize.height = newImageSize.height * maxWidth / newImageSize.width;
            newImageSize.width = maxWidth;
        }
        if (newImageSize.height > maxHeight) {
            newImageSize.width = newImageSize.width * maxHeight / newImageSize.height;
            newImageSize.height = maxHeight;
        }
        UIGraphicsBeginImageContext(newImageSize);
        self.draw(in: CGRect(x:0, y:0, width:newImageSize.width,height: newImageSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage!;
    }
}
