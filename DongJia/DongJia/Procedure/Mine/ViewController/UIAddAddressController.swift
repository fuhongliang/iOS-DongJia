//
//  UIAddAddressController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIAddAddressController: UBaseViewController {

    let addAddressView = UAddAddressView()
    
    override func configUI() {
        self.view.addSubview(addAddressView)
        addAddressView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
