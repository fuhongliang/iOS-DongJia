//
//  UBaseViewController.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Reusable
import Kingfisher

class UBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.background
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }

    func configUI() {}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.theme)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                addNavigationBarBackView()
            }
        }
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        guard navigationController == nil else {
            navigationController!.pushViewController(viewController,animated: true)
            return
        }
        topVC?.navigationController?.pushViewController(viewController, animated: true)
    }

    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension UBaseViewController {
    
    func addNavigationBarBackView(){
        let leftItem = UIBarButtonItem(image: UIImage(named: "black_back"), target: self, action: #selector(pressBack))
        if #available(iOS 11, *) {
            self.navigationItem.leftBarButtonItems = [leftItem]
        } else {
            // 用于消除左边空隙，要不然按钮顶不到最左边
            let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            leftSpace.width = -16
            self.navigationItem.leftBarButtonItems = [leftSpace, leftItem]
        }
    }
    
    /// 给系统导航栏添加左边View(删除左边20间隔)
    ///
    /// - Parameter leftView: leftView
    func addNavigationBarLeftView(_ leftView: UIView) {
        let leftItem = UIBarButtonItem(customView: leftView)
        if #available(iOS 11, *) {
            self.navigationItem.leftBarButtonItems = [leftItem]
        } else {
            // 用于消除左边空隙，要不然按钮顶不到最左边
            let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            leftSpace.width = -16
            self.navigationItem.leftBarButtonItems = [leftSpace, leftItem]
        }
    }
    
    /// 给系统导航栏添加右边View(删除右边20间隔)
    ///
    /// - Parameter rightView: rightView
    func addNavigationBarRightView(_ rightView: UIView) {
        let rightItem = UIBarButtonItem(customView: rightView)
        if #available(iOS 11, *) {
            self.navigationItem.rightBarButtonItems = [rightItem]
        } else {
            // 用于消除右边空隙，要不然按钮顶不到最右边
            let rightSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            rightSpace.width = -16
            self.navigationItem.rightBarButtonItems = [rightSpace, rightItem]
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
    
    
    func getTopViewController() -> UIViewController {
        let keywindow = (UIApplication.shared.delegate as! AppDelegate).window//UIApplication.shared.keyWindow使用此有时会崩溃
        let firstView: UIView = (keywindow?.subviews.first)!
        let secondView: UIView = firstView.subviews.first!
        var vc = viewForController(view: secondView)!
        vc = ((vc as! UITabBarController).selectedViewController! as! UINavigationController).visibleViewController!
        
        return vc
    }
    
    private func viewForController(view:UIView)->UIViewController?{
        var next:UIView? = view
        repeat{
            if let nextResponder = next?.next, nextResponder is UIViewController {
                return (nextResponder as! UIViewController)
            }
            next = next?.superview
        }while next != nil
        return nil
    }
    
}
