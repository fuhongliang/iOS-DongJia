//
//  UShopCartViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UShopCartViewController: UBaseViewController {

    let shopCartView = UShopCartView()
    override func configUI() {
        self.view.addSubview(shopCartView)
        shopCartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
