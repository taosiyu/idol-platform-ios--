
//
//  TableViewDelegate.swift
//  NewChama
//
//  Created by ncm on 2017/4/24.
//  Copyright © 2017年 com.NewChama. All rights reserved.
//

import UIKit

protocol TableViewDataDelegate: class {
    associatedtype Object: NSObject
    associatedtype TableView: UITableView
    func didClick(objects: [Object],indexPath: IndexPath)
}

class TableViewDelegate<Delegate: TableViewDataDelegate>: NSObject,UITableViewDelegate {
    
    typealias Object = Delegate.Object
    typealias TableView = Delegate.TableView
    
    
    private let tableView: UITableView
    private weak var delegate: Delegate!
    
    //全部的内容
    private var objects:[Object] = [Object]()
    
    required init(tableView: UITableView, delegate: Delegate)
    {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        tableView.delegate = self
        tableView.reloadData()
        
    }
    
    //MARK:delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didClick(objects: objects, indexPath: indexPath)
    }

    
}
