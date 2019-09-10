//
//  UIViewExtension.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/7/31.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

extension UIView {
    //设置部分圆角
    func setRoundCorners(corners:UIRectCorner,with radii:CGFloat){
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        
        self.layer.mask = shape
    }
}

