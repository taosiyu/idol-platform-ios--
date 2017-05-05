//
//  Bundle+EXtensions.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

extension Bundle {
    
    var namespace:String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
}
