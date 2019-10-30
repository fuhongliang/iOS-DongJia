//
//  UIAllCategoriesController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/30.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIAllCategoriesController: UBaseViewController {

    let categoriesView = UAllCategoriesView()
    override func configUI() {
        categoriesView.delegate = self
        view.addSubview(categoriesView)
        categoriesView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
}
extension UIAllCategoriesController: UAllCategoriesViewDelegate{
    func primaryClassificationClick() {
        showHUDInView(text: "点击一级菜单", inView: view, isClick: true)
    }
    
    func secondaryClassificationClick() {
        showHUDInView(text: "点击二级菜单", inView: view, isClick: true)
    }
    
    
}
