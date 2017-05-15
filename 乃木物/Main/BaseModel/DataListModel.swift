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
    var timeStr = ""
    var type = DataType.blog        //文章类型
    var title = ""                //文章标题
    var subtitle = ""             //文章副标题
    var provider = ""             //提供者 （ 字幕组名字 ）
    var summary = ""              //文章摘要
    var detail = ""               //文章详情
    var view = ""                 //文章预览（移动端页面）
    var withpic = [DataListImagesModel](){
        didSet{
            if withpic.count > 2{
                self.isThreeImage = true
            }else{
                self.isThreeImage = false
            }
        }
    }//文章附图
    
    //收藏用
    var images = ""{
        didSet{
            let array = images.components(separatedBy: "#")
            if array.count > 0{
                var models = [DataListImagesModel]()
                for str in array {
                    if !str.isEmpty{
                        let m = ModelFactory.new(type: DataListImagesModel.self)
                        m.image = str
                        models.append(m)
                    }
                }
                if models.count > 0{
                    self.withpic = models
                }
            }
        }
    }
    
    var isThreeImage = false
    
    //详情
    var article = ""  //全文详情html字段
    
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
        timeStr = delivery.toDateString
        article <- map["article"]
        images <- map["images"]
        id <- map["detailId"]
    }
    
    //MARK:获取插入语句
    func getInsertSQL()->String{
        var sql = "INSERT INTO \(SQLTableView) (timeStr,detailId,title,provider,summary,images)VALUES ("
        sql += "\(timeStr),"
        sql += "\(self.id),"
        sql += "\(title),"
        sql += "\(provider),"
        sql += "\(summary),"
        for image in withpic{
            sql += "\(image.image)#"
        }
        return sql
    }
    
    func getData()->[String:String]{
        var dic = [String:String]()
        dic["timeStr"] = timeStr
        dic["detailId"] = self.id
        dic["title"] = title
        dic["provider"] = provider
        dic["summary"] = summary
        var images = ""
        for image in withpic{
            images += "\(image.image)#"
        }
        dic["images"] = images
        return dic
    }
    
    func getWeb()->String{
        var html = "<!DOCTYPE html><html><head>"
        html+="<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
        html+="<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"/>"
        html+="</head>"
        html+=String.baseStyle
        html+="<body>"
        html+="<div style=\"background-color:#d4237a;color:white;padding:2px\">"
        html+=self.title.html_strong
        html+=self.type.hasValue
        html+="<br>"
        html+=self.provider.html_float(type: .left)
        html+=self.timeStr.html_float(type: .right)
        html+=HTML.clearFloat
        html+="<br>"
        html+="</div>"
        html+="<hr />"
        html+=self.article
        html+="</body>"
        html+="</html>"
        return html
    }
}

class DataListImagesModel:BaseModel {
    
    var image = ""
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        image <- map["image"]
    }
    
}
