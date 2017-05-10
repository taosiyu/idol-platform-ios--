//
//  BaseModel.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import ObjectMapper

class ModelFactory: NSObject {
    static func new<T: BaseModel>(type: T.Type) -> T {
        let model = Mapper<T>().map(JSON: ["id": "-1"])!
        return model
    }
}

class BaseModel: NSObject,Mappable{
    
    var id = ""
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
    }
    
    static func resetModel<T: BaseModel>() -> T {
        let model = Mapper<T>().map(JSON: ["id": "-1"])!
        return model
    }

}

