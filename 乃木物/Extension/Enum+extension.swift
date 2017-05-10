//
//  Enum+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

enum DataType:String {
    case news = "news"
    case blog = "blog"
    case magazine = "magazine"
    
    var hasValue:String{
        switch self {
        case .news:
            return "新闻"
        case .blog:
            return "博客"
        case .magazine:
            return "杂志"
        }
    }
}
