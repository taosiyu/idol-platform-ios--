//
//  ThreadTool.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class ThreadTool: NSObject {
    static func main(block:@escaping VoidClosure){
        DispatchQueue.main.async {
            block()
        }
    }
    
    static func after(time:TimeInterval,block:@escaping VoidClosure){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+time) {
            block()
        }
    }
}
