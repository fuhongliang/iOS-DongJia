//
//  Global.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh
import SCLAlertView

/// 屏幕宽高
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

/// 状态栏高度
let statusbarHeight = UIApplication.shared.statusBarFrame.height

// 获取App的版本号
let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "1.0.0") as! String
// 获取App的build版本
let appBuildVersion:String = (Bundle.main.infoDictionary?["CFBundleVersion"] ?? "1") as! String
// 获取App的名称
let appName:String = (Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? "懂家") as! String

//MARK:时间戳转日期时间
func dateForMatter(timeString:Int, join:String) -> String{
    let timeInterval = TimeInterval(timeString)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dateForMatter = DateFormatter()
    dateForMatter.dateFormat = "yyyy.MM.dd"+join+"HH:mm:ss"
    return dateForMatter.string(from: date)
}

func stringArrayConvertDoubleArray(stringArray:[String]) -> [Double]{
    var icome : [Double] = []
    for number in stringArray {
        icome.append(Double(number) as! Double)
    }
    return icome
}

extension UIColor {
    class var background: UIColor {
        return UIColor(r: 245, g: 245, b: 245)
    }

    class var theme: UIColor {
        return UIColor(r: 14, g: 194, b: 98)
    }
}

//显示弹窗
func showAlert(title:String = "提示", subTitle:String = "", block:((_ alertView:SCLAlertView) -> ())?) {
    let style = SCLAlertView.SCLAppearance(
        kWindowWidth: 300, kTitleFont: UIFont(name: "HelveticaNeue-Bold", size: 20)!,
        kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
        kButtonFont: UIFont(name: "HelveticaNeue", size: 18)!,
        showCloseButton: false,
        showCircularIcon: false,
        hideWhenBackgroundViewIsTapped:true,
        buttonsLayout: .horizontal
    )
    let alertView = SCLAlertView(appearance: style)
    block?(alertView)
    alertView.showEdit(title, subTitle: subTitle, colorStyle: 0xFFFFFF, animationStyle:.noAnimation)
}

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK: SnapKit
extension ConstraintView {

    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

//MARK: -定义button相对label的位置
enum YWButtonEdgeInsetsStyle {
    case Top
    case Left
    case Right
    case Bottom
}

extension UIButton {
    
    /// 设置图片在上面 文字在下面 (延展性待测试)
    func setImgUpTitleDown() {
        self.contentHorizontalAlignment = .center
        self.contentMode = .center
        self.titleEdgeInsets = UIEdgeInsets.init(top: (self.imageView?.frame.size.height ?? 0) + 5, left: (self.frame.width-(self.titleLabel?.frame.width ?? 0)), bottom: 0, right: 0)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 19, right: self.frame.width-(self.titleLabel?.frame.width ?? 0)*1.5)
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
