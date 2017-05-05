//
//  Label.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    
    internal override func draw(_ rect: CGRect) {
        super.draw(UIEdgeInsetsInsetRect(rect, self.edgeInsets))
    }
    
    var edgeInsets: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = " "
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        get{
            var size = super.intrinsicContentSize
            size.width += self.edgeInsets.left + self.edgeInsets.right
            size.height += self.edgeInsets.top + self.edgeInsets.bottom
            return size
        }
    }
    
}
