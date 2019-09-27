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

/// 获取App的版本号
let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "1.0.0") as! String
/// 获取App的build版本
let appBuildVersion:String = (Bundle.main.infoDictionary?["CFBundleVersion"] ?? "1") as! String
/// 获取App的名称
let appName:String = (Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? "懂家") as! String

/// 时间戳转日期时间
func dateForMatter(timeString:Int, join:String) -> String{
    let timeInterval = TimeInterval(timeString)
    let date = Date(timeIntervalSince1970: timeInterval)
    let dateForMatter = DateFormatter()
    dateForMatter.dateFormat = "yyyy.MM.dd"+join+"HH:mm:ss"
    return dateForMatter.string(from: date)
}

/// string数组转Double数组
func stringArrayConvertDoubleArray(stringArray:[String]) -> [Double]{
    var icome : [Double] = []
    for number in stringArray {
        icome.append(Double(number)!)
    }
    return icome
}

/// 显示一个弹窗
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

/// 当前顶部控制器
var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private func _topVC(_ vc: UIViewController?) -> UIViewController? {
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
