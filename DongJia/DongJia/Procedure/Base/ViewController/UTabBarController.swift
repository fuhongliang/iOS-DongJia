//
//  UTabBarController.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    let mainVC = ViewController()
    let dosVC = ViewController() //家装方案
    let shoppingCartVC = ViewController()
    let mineVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false

        /// 首页
        addChildViewController(mainVC,
                               title: "首页",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home_S"))

        /// 家装方案
        addChildViewController(dosVC,
                               title: "家装方案",
                               image: UIImage(named: "tab_manager_orders"),
                               selectedImage: UIImage(named: "tab_manager_orders_S"))

        /// 购物车
        addChildViewController(shoppingCartVC,
                               title: "购物车",
                               image: UIImage(named: "tab_goods"),
                               selectedImage: UIImage(named: "tab_goods_S"))
        
        /// 我的
        addChildViewController(mineVC,
                               title: "我的",
                               image:  UIImage(named: "tab_setting"),
                               selectedImage: UIImage(named: "tab_setting_S"))

    }

    func addChildViewController(_ childController: UIViewController, title:String?,navigateTile:String = "", image:UIImage? ,selectedImage:UIImage?) {

        childController.title = navigateTile == "" ? title : navigateTile
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        childController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0);

        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        addChild(UNavigationController(rootViewController: childController))
    }

}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}

