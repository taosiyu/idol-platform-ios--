//
//  RefreshView.swift
//  乃木物
//
//  Created by ncm on 2017/5/8.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import MJRefresh

private let limitCount = 10
class RefreshView: UITableView {
    
    private(set) var refreshCount = 1   //下载数据用的
    
    var nowCount = 0{
        didSet{
            if nowCount >= limitCount{
                mj_footer.isHidden = false
                refreshCount += 1
            }else{
                mj_footer.isHidden = true
                self.footerEndRefreshWithNoMoreData()
                refreshCount = 1
            }
        }
    }

    convenience init() {
        self.init(frame:CGRect())
        tableFooterView = UIView()
        separatorStyle = .none
        self.setupView()
    }
    
    convenience init(style: UITableViewStyle) {
        self.init(frame: CGRect(), style: style)
        tableFooterView = UIView()
        separatorStyle = .none
        self.setupView()
    }
    
    private func setupView(){
        mj_header = MJRefreshNormalHeader.init()
        mj_footer = MJRefreshAutoNormalFooter.init()
        mj_footer.isHidden = true
    }

    func headerBeginRefreshing() {
        if !mj_header.isRefreshing(){
            mj_header?.beginRefreshing()
        }
    }
    var headerIsRefreshing: Bool {
        return mj_header?.isRefreshing() ?? false
    }
    
    var isLoading = false
    
    func headerEndRefreshing() {
        if headerIsRefreshing {
            mj_header?.endRefreshing()
        }
    }
    
    func setHeaderRefreshClosure(closure: @escaping VoidClosure) {
        mj_header.refreshingBlock = {
            if self.isLoading{
                return
            }else{
                self.isLoading = true
            }
            self.refreshCount = 1
            self.footerEndRefreshing()
            self.footResetNoMoreData()
            closure()
        }
    }
    
    //footer
    func footerBeginRefreshing() {
        if !mj_footer.isRefreshing(){
            mj_footer?.beginRefreshing()
        }
    }
    
    var footerIsRefreshing: Bool {
        return mj_footer?.isRefreshing() ?? false
    }
    
    func footerEndRefreshing() {
        if footerIsRefreshing {
            mj_footer?.endRefreshing()
        }
    }
    
    func footerEndRefreshWithNoMoreData() {
        mj_footer?.endRefreshingWithNoMoreData()
    }
    
    func footResetNoMoreData() {
        mj_footer?.resetNoMoreData()
    }
    
    func setFooterRefreshClosure(closure: @escaping VoidClosure) {
        mj_footer?.refreshingBlock = {
            if self.isLoading {
                return
            }else{
                self.isLoading = true
            }
            self.headerEndRefreshing()
            closure()
        }
    }
    
    
    func endRefreshing() {
        headerEndRefreshing()
        footerEndRefreshing()
        self.isLoading = false
    }
}
