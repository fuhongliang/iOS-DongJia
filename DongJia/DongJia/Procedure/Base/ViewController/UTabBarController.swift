//
//  UTabBarController.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    let mainVC = UIMainController()
    let dosVC = UIDosController() //家装方案
    let shoppingCartVC = UShopCartViewController()
    let mineVC = UIMineController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false

        /// 首页
        addChildViewController(mainVC,
                               title: "首页",
                               image: UIImage(named: "tab_main"),
                               selectedImage: UIImage(named: "select_tab_main"))

        /// 家装方案
        addChildViewController(dosVC,
                               title: "家装方案",
                               image: UIImage(named: "tab_dos"),
                               selectedImage: UIImage(named: "select_tab_dos"))

        /// 购物车
        addChildViewController(shoppingCartVC,
                               title: "购物车",
                               image: UIImage(named: "tab_shop_cart"),
                               selectedImage: UIImage(named: "select_tab_shop_cart"))
        
        /// 我的
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "select_tab_mine"))

    }

    func addChildViewController(_ childController: UIViewController, title:String?,navigateTile:String = "", image:UIImage? ,selectedImage:UIImage?) {

        childController.title = navigateTile == "" ? title : navigateTile
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        childController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0);
        childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hex(hexString: "#0EC262")], for: .selected) //设置选中文本的颜色
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        addChild(UNavigationController(rootViewController: childController))
    }

}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .default }
        return select.preferredStatusBarStyle
    }
}

