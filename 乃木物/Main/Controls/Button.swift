//
//  Button.swift
//  乃木物
//
//  Created by ncm on 2017/5/5.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit
import SnapKit

class BaseButton: UIButton {
    //放大点击热区
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds = self.bounds
        let widthDelta = max(44.0 - bounds.size.width, 0)
        let heightDelta = max(44.0 - bounds.size.height, 0)
        bounds = bounds.insetBy(dx: -0.5 * widthDelta, dy: -0.5 * heightDelta)
        return bounds.contains(point)
    }
}

class NavIconButton: BaseButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.snp.makeConstraints { (make) in
            let diameter: CGFloat = Layout.NavIconBtnDiameter
            make.size.equalTo(CGSize(width:diameter, height:diameter))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BackButton: NavIconButton {
    var light = true {
        didSet {
            if light {
                setImage(UIImage.init(named: "icon_back_white"), for: .normal)
            } else {
                setImage(UIImage.init(named: "icon_back_black"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage.init(named: "icon_back_white"), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
