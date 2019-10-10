//
//  UILabelExtension.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

extension UILabel {
    
    /// 设置行间距
    func setTextAndLineSpacing(text: String? = nil, fontSize:CGFloat = UIFont.systemFontSize, space: CGFloat){
        
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //设置行间距
        paraph.lineSpacing = space
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: fontSize), NSAttributedString.Key.paragraphStyle: paraph]
        self.attributedText = NSAttributedString(string: text ?? self.text!, attributes: attributes)
        self.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
    
    /// 设置中划线
    func setUnderLine(text: String){
        let priceString = NSMutableAttributedString.init(string: text)
        priceString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSNumber.init(value: 1), range: NSRange(location: 0, length: priceString.length))
        self.attributedText = priceString
    }
    
}
