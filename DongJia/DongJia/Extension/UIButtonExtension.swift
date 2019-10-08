//
//  UIButtonExtension.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/26.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

//MARK: -定义button相对label的位置
enum YWButtonEdgeInsetsStyle {
    /// 文字在上 图片在下
    case Top
    /// 文字在左 图片在右
    case Left
    /// 文字在右 图片在左
    case Right
    /// 文字在下 图片在上
    case Bottom
}

extension UIButton {
    
    /// 设置图片文字位置 (需要指定宽度-如果使用divideby平分会计算错误)
    func setButtonShowType(_ type:YWButtonEdgeInsetsStyle) {
        self.layoutIfNeeded()
        let titleFrame = self.titleLabel!.frame
        let imageFrame = self.imageView!.frame
        
        let space = titleFrame.origin.x - imageFrame.origin.x - imageFrame.size.width + 4
        
        switch (type) {
        case .Left:
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleFrame.size.width + space, bottom: 0, right: -(titleFrame.size.width + space))
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(titleFrame.origin.x - imageFrame.origin.x), bottom: 0, right: titleFrame.origin.x - imageFrame.origin.x)
        case .Top:
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -(imageFrame.size.width), bottom: imageFrame.size.height + space, right: 0)
            self.titleEdgeInsets = UIEdgeInsets.init(top: titleFrame.size.height + space, left: titleFrame.size.width, bottom: 0, right: 0)
        case .Right:
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: imageFrame.size.width - space, bottom: 0, right: -(imageFrame.size.width - space))
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(titleFrame.origin.x - imageFrame.origin.x), bottom: 0, right: imageFrame.origin.x - titleFrame.origin.x)
        case .Bottom:
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: titleFrame.size.height + space, right: -(titleFrame.size.width))
            self.titleEdgeInsets = UIEdgeInsets.init(top: imageFrame.size.height + space, left: -(imageFrame.size.width), bottom: 0, right: 0)
        }
    }
    
    /// imageTitleSpace 图片文字相反方向的移动
    /// styleSpace 对应方向的整体移动间距
    func layoutButton(style: YWButtonEdgeInsetsStyle, imageTitleSpace: CGFloat, styleSpace:CGFloat = 0) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .Top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-imageTitleSpace/2 + styleSpace, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: styleSpace, left: -imageWidth!, bottom: -imageHeight!-imageTitleSpace/2, right: 0)
            break;
            
        case .Left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageTitleSpace/2 + styleSpace, bottom: 0, right: imageTitleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: imageTitleSpace/2 + styleSpace, bottom: 0, right: -imageTitleSpace/2)
            break;
            
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-imageTitleSpace/2 + styleSpace, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-imageTitleSpace/2, left: -imageWidth!, bottom: styleSpace, right: 0)
            break;
            
        case .Right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+imageTitleSpace/2, bottom: 0, right: -labelWidth-imageTitleSpace/2 + styleSpace)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-imageTitleSpace/2, bottom: 0, right: imageWidth!+imageTitleSpace/2 + styleSpace)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
    }
}
