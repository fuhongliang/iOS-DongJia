//
//  UIGoodsDetailController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/26.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIGoodsDetailController: UBaseViewController {

    let goodsDetailView = UGoodsDetailView()
    
    override func configUI() {
        self.view.addSubview(goodsDetailView)
        goodsDetailView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
