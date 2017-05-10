//
//  String+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import Foundation

typealias HTML = String
extension String {
    
    var fixUrlString: String {
        var str = self
        if !str.hasPrefix("https://") {
            str = API.ServerHost + str
        }
        
        let suf = "/"
        
        if !str.hasSuffix(suf) {
            str = str + suf
        }
        
        return str
    }

    var fixImgUrlString: String {
        var str = fixUrlString
        let suf = "/"
        if str.hasSuffix(suf) {
            str = str.substring(to: str.index(endIndex, offsetBy: -1))
        }
        return str
    }
    
    var fixImgUrl: URL {
        return URL.init(string: self)!
    }
    
    //MARK:获取标准的web
    var baseWeb:String {
        var html = "<!DOCTYPE html><html><head>"
        html+="<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">"
        html+="<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"/>"
        html+="</head>"
        html+=String.baseStyle
        html+="<body>"
        html+=self
        html+="</body>"
        html+="</html>"
        return html
    }
    
    //MARK:===========>>>>>>>>  HTML  <<<<<<<<==================
    
    static var baseStyle:String{
        var html = "<style>"
        html+="img{width: 100%;}"
        html+="</style>"
        return html
    }
    
    //MARK:加粗
    var html_strong:String{
        var html = "<div style=\"font-weight: bold;\">"
        html+=self
        html+="</div>"
        return html
    }
    
    //MARK:添加间距
    func html_margin(margin:CFloat)->String{
        var html = "<div style=\"margin:\(margin);\">"
        html+=self
        html+="</div>"
        return html
    }
    //MARK:字体大小
    func html_font(size:CFloat)->String{
        var html = "<p style=\"font-size: \(size);\">"
        html+=self
        html+="</p>"
        return html
    }
    
    //MARK:浮动
    enum FloatType {
        case left,right
        var row:String{
            switch self {
            case .left:
                return "left"
            default:
                return "right"
            }
        }
    }
    func html_float(type:FloatType)->String{
        var html = "<div style=\"float: \(type.row);\">"
        html+=self
        html+="</div>"
        return html
    }
    
    //MARK:清楚浮动
    static var clearFloat:String{
        var html = "<div style=\"both:clear;\">"
        html+="</div>"
        return html
    }
    
    //Index

}















