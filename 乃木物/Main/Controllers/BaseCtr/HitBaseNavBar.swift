//
//  HitBaseNavBar.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

class HitBaseNavBar: UIToolbar {
    
    /// 背景色
    var backColor: UIColor! {
        didSet {
            backImage = UIImage.imageWithColor(color: backColor)
        }
    }
    ///给背景
    var backImage: UIImage! {
        didSet {
            setBackgroundImage(backImage, forToolbarPosition: .any, barMetrics: .default)
        }
    }
    
    //初始化方法
    convenience init() {
        self.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var leftV = UIView()
    var rightV = UIView()
    
    var hidesBackButton: Bool{
        didSet{
            refreshLeftItems()
        }
    }
    
    /// 返回按钮
    var backItem = BackButton()
    
    private func refreshLeftItems(){
        var conV: UIView!
        var preV: UIView!
        var view: UIView!
        
        conV = leftV
        conV.removeAllSubviews()
        var items = [UIView]()
        
        if !hidesBackButton {
            items.append(backItem)
        }
        
//        items.appendContentsOf(leftItems)
//        
//        for (_, value) in items.enumerate() {
//            view = value
//            
//            conV.addSubview(view)
//            view.snp_makeConstraints { (make) in
//                make.centerY.equalTo(conV)
//                if (preV == nil) {
//                    make.left.equalTo(conV)
//                } else {
//                    make.left.equalTo(preV.snp_right).offset(Layout.Digit8)
//                }
//                
//                if view == items.last {
//                    make.right.equalTo(conV)
//                }
//            }
//            preV = view
//        }
    }


}


class TitleLabel: BaseLabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont.boldSystemFont(ofSize: 18)
        textAlignment = NSTextAlignment.center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
