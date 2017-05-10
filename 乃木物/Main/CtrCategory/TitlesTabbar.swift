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
    
    fileprivate lazy var fontColor = UIColorFromRGB(rgbValue: 0x00a0e8)
    
    fileprivate lazy var backColor = UIColor.black
    
    fileprivate var lineWidth:CGFloat = 0
    
    private var selectedButton = UIButton()
    
    var buttonClick:((Int)->())?
    
    fileprivate var bottomLine:UIView = {
        let vc = UIView.init()
        vc.backgroundColor = UIColorFromRGB(rgbValue: 0x00a0e8)
        return vc
    }()
    
    var lineColor:UIColor = UIColorFromRGB(rgbValue: 0x00a0e8){
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
        self.backgroundColor = UIColor.white
        if let strs = self.titiles {
            for (index,title) in strs.enumerated() {
                let btn = UIButton.init()
                btn.setTitle(title, for: UIControlState.normal)
                btn.setTitleColor(fontColor, for: UIControlState.disabled)
                btn.setTitleColor(backColor, for: UIControlState.normal)
                btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
                btn.tag = index
                btn.addTarget(self, action: #selector(buttonClick(btn:)), for: UIControlEvents.touchDown)
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
    
    @objc fileprivate func buttonClick(btn:UIButton){
        if let clo = buttonClick {
            clo(btn.tag)
        }
        selectedButton.isEnabled = true
        selectedButton = btn
        selectedButton.isEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.curveLinear, animations: {[unowned self] in
            self.bottomLine.frame.origin.x = btn.frame.origin.x
        }, completion: nil)
    }
    
    func setButtonLine(index:Int,present:CGFloat){
        if present == 0{
            let button = self.buttons[index]
            button.sendActions(for: UIControlEvents.touchDown)
        }else{
            let begin = index.CF*lineWidth
            let distance = lineWidth*present
            self.bottomLine.frame.origin.x = begin + distance
        }
        
    }
    
    func setBeginButton(index:Int){
        let button = self.buttons[index]
        button.sendActions(for: UIControlEvents.touchDown)
    }

}





