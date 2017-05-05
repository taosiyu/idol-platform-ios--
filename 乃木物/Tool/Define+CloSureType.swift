//
//  Define+CloSureType.swift
//  PoliceTool
//
//  Created by ncm on 2017/2/9.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

//一些常用的定义

//typealias Dic               = [String: String]?  //字典
typealias Dic               = [String: AnyObject]?
typealias Eic               = [String: AnyObject]

typealias SuccessedClosure = (_ dataObj: [String: AnyObject]) -> Void
typealias ErrorClosure = (_ statusCode: Int, _ message: String) -> Void
typealias FailedClosure = (_ error: NSError) -> Void


let MainApp           = UIApplication.shared.delegate as! AppDelegate

let StandardDefaults = UserDefaults.standard
let ScreenBounds     = UIScreen.main.bounds
let ScreenWidth      = ScreenBounds.size.width
let ScreenHeight     = ScreenBounds.size.height


//颜色
func UIColorFromRGB(rgbValue: Int) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//debug下的信息输出
func dLog(_ message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        print("[\(NSURL(string: filename)?.lastPathComponent!):\(line)] \(function) - \(message)")
    #endif
}
