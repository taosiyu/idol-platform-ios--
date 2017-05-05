
//
//  MainBaseModel.swift
//  NewChama
//
//  Created by tsy on 2017/5/7.
//  Copyright © 2017年 peachRain All rights reserved.
//

import UIKit

protocol MainViewModel {}

//model的默认实现
extension MainViewModel where Self:TableModelDelegate {
    typealias MainModel = BaseModel
    func objects()->[BaseModel]{
        return [BaseModel]()
    }
}
