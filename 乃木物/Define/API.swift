//
//  API.swift
//  PoliceTool
//
//  Created by ncm on 2017/2/9.
//  Copyright © 2017年 ncm. All rights reserved.
//

import Foundation

class API: NSObject {
    
    //乃木物地址
    static let ServerHost = "https://platform.idolx46.top/data"

    //下载文件的路径
    static let documentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    //下载图片的路径
    static let downloadImagePath = [documentPath].joined(separator: "/image")
    
    
    //class name:NSObject 下面是所有用到的api
    class data: NSObject {
        static let list = "/list"                           //所有文章
        static let blog = "/list?type=blog"                 //博客文章
        static let news = "/list?type=news"                 //新闻文章
        static let magazine = "/list?type=magazine"         //杂志文章
    }

}
