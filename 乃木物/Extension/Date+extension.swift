//
//  Date+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/8.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

extension DateFormatter{
    
    static func yymmddHHmm()->DateFormatter{
        let formatter = DateFormatter()
        let timeZone = TimeZone.init(identifier: "UTC")
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }
}

extension TimeInterval{
    
    var toDateString:String{
        let dateTime = Date.init(timeIntervalSince1970: self)
        let formatter = DateFormatter.yymmddHHmm()
        let timeStr = formatter.string(from: dateTime)
        return timeStr
    }
}
