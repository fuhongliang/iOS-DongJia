//
//  UIAboutUsController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIAboutUsController: UBaseViewController {
    
    let aboutUsView = UAboutUsView()
    override func configUI() {
        self.view.addSubview(aboutUsView)
        aboutUsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
