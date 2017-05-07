//
//  TitlesTabbar.swift
//  乃木物
//
//  Created by ncm on 2017/5/7.
//  Copyright © 2017年 TSY. All rights reserved.
//

import UIKit


private let lineH = 2 //底部线高
class TitlesTabbar: UIView {
    
    fileprivate var titiles:[String]?
    
    fileprivate var buttons = [UIButton]()
    
    fileprivate lazy var fontColor = UIColor.blue
    
    fileprivate lazy var backColor = UIColor.black
    
    fileprivate var lineWidth:CGFloat = 0
    
    fileprivate var bottomLine:UIView = {
        let vc = UIView.init()
        vc.backgroundColor = UIColor.blue
        return vc
    }()
    
    var lineColor:UIColor = UIColor.blue{
        didSet{
            bottomLine.backgroundColor = lineColor
        }
    }

    convenience init(titles:[String]) {
        self.init(frame:CGRect())
        self.titiles = titles
        self.setButtonWithTitles()
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:设置button
    private func setButtonWithTitles(){
        if let strs = self.titiles {
            for (index,title) in strs.enumerated() {
                let btn = UIButton.init()
                btn.setTitle(title, for: UIControlState.normal)
                btn.setTitleColor(fontColor, for: UIControlState.selected)
                btn.setTitleColor(backColor, for: UIControlState.normal)
                btn.tag = index
                self.addSubview(btn)
                self.buttons.append(btn)
            }
        }
    }
    
    //MARK:是否显示下划线
    func showBottomLine(){
        self.addSubview(self.bottomLine)
        let width = UIScreen.main.bounds.width/CGFloat(self.buttons.count)
        self.lineWidth = width
        let height = self.frame.size.height-lineH.CF
        bottomLine.frame = CGRect(x: 0, y: height, width: width, height: lineH.CF)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = UIScreen.main.bounds.width/CGFloat(self.buttons.count)
        let height = self.frame.size.height
        for (index,btn) in self.buttons.enumerated() {
            btn.frame = CGRect(x: CGFloat(index)*width, y: 0, width: width, height: height)
        }
    }

}





