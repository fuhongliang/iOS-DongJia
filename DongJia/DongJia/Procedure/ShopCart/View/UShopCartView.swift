//
//  UShopCartView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UShopCartView: BaseView {

    let view = ArcView().then{
        $0.fillColor = .random
        $0.arcHeight = 80
        $0.backgroundColor = .background
    }
    override func configUI() {
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalTo(130)
        }
    }
    
}
