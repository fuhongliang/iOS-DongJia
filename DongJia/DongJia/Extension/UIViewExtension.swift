//
//  UIViewExtension.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/7/31.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

extension UIView {
    
     /// 设置部分圆角
     /// 使用 setRoundCorners(corners: [.bottomLeft,.bottomRight], with: 2)
    func setRoundCorners(corners:UIRectCorner,with radii:CGFloat){
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        
        self.layer.mask = shape
    }
    
    /// 设置四角的平切(未完成)
    private func makeStraightCutCorners(){
        var size = self.frame.size
        var shapeLayer = CAShapeLayer.init()
        shapeLayer.fillColor = UIColor.white.cgColor
        
        var path = CGMutablePath()
        
    }
    
}

