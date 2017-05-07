//
//  Dictionary+extension.swift
//  乃木物
//
//  Created by ncm on 2017/5/6.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    var results: Any? {
        return self["results"]
    }
}
