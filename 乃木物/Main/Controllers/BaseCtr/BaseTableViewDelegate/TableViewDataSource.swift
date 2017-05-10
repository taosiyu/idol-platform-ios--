//
//  TableViewDataSource.swift
//  NewChama
//
//  Created by tsy on 2017/5/7.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

protocol TableViewDataSourceDelegate: class {
    associatedtype Object: NSObject,TableModelDelegate
    associatedtype Cell: UITableViewCell
    func configure(cell: Cell, for object: Object,indexPath: IndexPath)
}

protocol TableModelDelegate: class {
    associatedtype MainModel: NSObject
    func objects()->[MainModel]
}

enum TableViewDataSourceType {
    case section,row,group
}

class TableViewDataSource<Delegate: TableViewDataSourceDelegate>: NSObject,UITableViewDataSource{
    
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    private let tableView: UITableView
    private weak var delegate: Delegate!
    private let cellIdentifier: String
    //全部的内容
    private var objects:[Object] = [Object]()
    
    private var rowType:TableViewDataSourceType = .row
    
    //MARK:设置数据
    func setObjects(objs:[Object]){
        self.objects.removeAll()
        self.objects = objs
        self.tableView.reloadData()
    }
    
    required init(tableView: UITableView, cellIdentier: String, delegate: Delegate,type:TableViewDataSourceType)
    {
        self.tableView = tableView
        self.cellIdentifier = cellIdentier
        self.delegate = delegate
        self.rowType = type
        super.init()
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return rowType == .row ? 1 : self.objects.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowType == .row ? self.objects.count : (rowType == .section ? 1 : self.objects[section].objects().count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? Cell else{
            return UITableViewCell.init()
        }
        switch rowType {
        case .row:
            let object = self.objects[indexPath.row]
            delegate.configure(cell: cell, for: object, indexPath: indexPath)
            break
        default:
            let object = self.objects[indexPath.section]
            delegate.configure(cell: cell, for: object, indexPath: indexPath)
            break
        }
        return cell
    }

}


