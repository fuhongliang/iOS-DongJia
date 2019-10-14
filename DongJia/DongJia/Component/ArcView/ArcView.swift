//
//  ArcView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

/// 显示一个底部是有弧度的View
class ArcView: UIView {
    /// 弧度的高度
    var arcHeight:CGFloat = 15
    /// view的颜色
    var fillColor: UIColor = .background
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        fillColor.set() // 设置线条颜色
        
        let x = rect.origin.x
        let y = rect.origin.y
        let w = rect.size.width
        let h = rect.size.height
        
        let rectPath = UIBezierPath(rect: CGRect(x: x, y: y, width: w, height: h-arcHeight/2))
        
        let aPath = UIBezierPath(ovalIn: CGRect(x: -(w/5), y: h-arcHeight-2, width: w*7/5, height: arcHeight)) // 如果传入的是长方形，画出的就是内切椭圆
        rectPath.fill()
        aPath.fill()
        
    }
    
    func setFillColor(_ fillColor: UIColor){
        self.fillColor = fillColor
        setNeedsDisplay()
    }

}
