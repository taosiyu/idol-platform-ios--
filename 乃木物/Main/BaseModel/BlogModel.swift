//
//  BlogModel.swift
//  乃木物
//
//  Created by ncm on 2017/5/11.
//  Copyright © 2017年 TSY. All rights reserved.
//

import ObjectMapper

class BlogModel: BaseModel {
    var post:TimeInterval = 0       //发布时间（时戳）
    var author = ""     //成员名
    var title = ""      //博客标题
    var summary = ""	//博客摘要 （ 官博移动版数据 ）
    var url     = ""
    var timeStr = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        post <- map["post"]
        author <- map["author"]
        title <- map["title"]
        summary <- map["summary"]
        url <- map["url"]
        timeStr = post.toDateString
    }
}
