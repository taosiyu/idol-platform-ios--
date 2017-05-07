//
//  DataListModel.swift
//  乃木物
//
//  Created by ncm on 2017/5/6.
//  Copyright © 2017年 TSY. All rights reserved.
//

import ObjectMapper

class DataListModel: BaseModel {
    var delivery:TimeInterval = 0 //文章投送时间
    var type = ""                 //文章类型
    var title = ""                //文章标题
    var subtitle = ""             //文章副标题
    var provider = ""             //提供者 （ 字幕组名字 ）
    var summary = ""              //文章摘要
    var detail = ""               //文章详情
    var view = ""                 //文章预览（移动端页面）
    var withpic = [DataListImagesModel]()              //文章附图
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        delivery <- map["delivery"]
        type <- map["type"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        provider <- map["provider"]
        summary <- map["summary"]
        detail <- map["detail"]
        view <- map["view"]
        withpic <- map["withpic"]
    }
}

class DataListImagesModel:BaseModel {
    
    var image = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        image <- map["image"]
    }
    
}
