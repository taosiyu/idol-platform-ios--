//
//  TableViewTwoCellDataSource.swift
//  乃木物
//
//  Created by ncm on 2017/5/9.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

protocol TableViewDataTwoCellSourceDelegate: class {
    associatedtype Object: NSObject,TableModelDelegate
    associatedtype Cell: UITableViewCell
    associatedtype CellTwo: UITableViewCell
    func configure(cell: Cell, for object: Object,indexPath: IndexPath)
    func configureTwo(cell: CellTwo, for object: Object,indexPath: IndexPath)
}

class TableViewTwoCellDataSource<Delegate: TableViewDataTwoCellSourceDelegate>: NSObject,UITableViewDataSource{
    
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    typealias CellTwo = Delegate.CellTwo
    
    private let tableView: UITableView
    private weak var delegate: Delegate!
    private let cellIdentifier: String
    private let cellIdentifierTwo: String
    //全部的内容
    private var objects:[Object] = [Object]()
    
    private var rowType:TableViewDataSourceType = .row
    
    private var changeTwoCellKey = ""
    
    //MARK:设置数据
    func setObjects(objs:[Object]){
        self.objects.removeAll()
        self.objects = objs
        self.tableView.reloadData()
    }
    
    required init(tableView: UITableView, cellIdentier: String,cellIdentierTwo: String, delegate: Delegate,type:TableViewDataSourceType,changeTwoCellKey:String)
    {
        self.tableView = tableView
        self.cellIdentifier = cellIdentier
        self.cellIdentifierTwo = cellIdentierTwo
        self.delegate = delegate
        self.rowType = type
        self.changeTwoCellKey = changeTwoCellKey
        super.init()
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return rowType == .row ? 1 : self.objects.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowType == .row ? self.objects.count : (rowType == .section ? 1 : self.objects[section].objects().count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var objectIndex = indexPath.row
        switch rowType {
        case .row:
            break
        default:
            objectIndex = indexPath.section
            break
        }
        let object = self.objects[objectIndex]
        //判断
        if self.getTypeKeyBool(object: object) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? Cell else{
                return Cell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifierTwo)
            }
            delegate.configure(cell: cell, for: object, indexPath: indexPath)
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifierTwo, for: indexPath) as? CellTwo else{
                return CellTwo(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifierTwo)
            }
            delegate.configureTwo(cell: cell, for: object, indexPath: indexPath)
            return cell
        }
    }

    //MARK:计算两个不同cell得区别符号
    private func getTypeKeyBool(object:NSObject)->Bool{
        let mirro = Mirror.init(reflecting: object)
        for child in mirro.children {
            let (key,value) = child
            if key == self.changeTwoCellKey {
                if let isBool = value as? Bool {
                    return isBool
                }else{
                    return false
                }
            }
        }
        return false
    }
}
