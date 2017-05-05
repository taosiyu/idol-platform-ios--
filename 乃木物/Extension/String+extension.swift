//
//  String+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import Foundation

extension String {
    
    var fixUrlString: String {
        var str = self
        if !str.hasPrefix("http://") {
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
        return URL.init(string: fixImgUrlString)!
    }
    
    //Index

}
