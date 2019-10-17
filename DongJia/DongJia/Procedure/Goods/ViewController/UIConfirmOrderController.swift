//
//  UIConfirmOrderController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIConfirmOrderController: UBaseViewController {
    
    /// 修改状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{ return .lightContent }
    
    let confirmOrderView = UConfirmOrderView()
    override func configUI() {
        self.view.addSubview(confirmOrderView)
        confirmOrderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationBar(barStyle: .theme)
    }

}
