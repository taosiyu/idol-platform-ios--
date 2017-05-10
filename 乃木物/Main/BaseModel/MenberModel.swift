//
//  MenberModel.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import ObjectMapper

class MenberModel: BaseModel {
    var name = ""
    var kana = ""
    var rome = ""
    var birthdate = ""
    var bloodtype = ""      //血型
    var constellation = ""
    var height = ""
    var status = ""
    var portrait = ""       //公式照
    var link = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        kana <- map["kana"]
        rome <- map["rome"]
        birthdate <- map["birthdate"]
        bloodtype <- map["bloodtype"]
        constellation <- map["constellation"]
        height <- map["height"]
        status <- map["status"]
        portrait <- map["portrait"]
        link <- map["link"]
    }

}
