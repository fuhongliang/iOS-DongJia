//
//  UILabelExtension.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

extension UILabel {
    
    func setTextAndLineSpacing(text: String, space: CGFloat){
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //设置行间距
        paraph.lineSpacing = space
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15), NSAttributedString.Key.paragraphStyle: paraph]
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
    
}
