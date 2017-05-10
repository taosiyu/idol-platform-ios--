//
//  CollectionViewDataSource.swift
//  乃木物
//
//  Created by ncm on 2017/5/10.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

protocol CollectionViewDataSourceDelegate: class {
    associatedtype Object: NSObject
    associatedtype Cell: UICollectionViewCell
    func configure(cell: Cell, for object: Object,indexPath: IndexPath)
}

class CollectionViewDataSource<Delegate: CollectionViewDataSourceDelegate>: NSObject ,UICollectionViewDataSource{
    
    typealias Object = Delegate.Object
    typealias Cell = Delegate.Cell
    
    private let collectionView: UICollectionView
    
    private weak var delegate: Delegate!
    private let cellIdentifier: String
    //全部的内容
    private var objects:[Object] = [Object]()
    
    //MARK:设置数据
    func setObjects(objs:[Object]){
        self.objects.removeAll()
        self.objects = objs
        self.collectionView.reloadData()
    }
    
    required init(collectionView: UICollectionView, cellIdentier: String, delegate: Delegate)
    {
        self.collectionView = collectionView
        self.cellIdentifier = cellIdentier
        self.delegate = delegate
        super.init()
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? Cell else{
            return Cell()
        }
        let object = self.objects[indexPath.row]
        delegate.configure(cell: cell, for: object, indexPath: indexPath)
        return cell
    }

}
