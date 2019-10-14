//
//  UIChooseCityController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIChooseCityController: UBaseViewController {

    let chooseCityView = UChooseCityView()
    
    override func configUI() {
        view.addSubview(chooseCityView)
        chooseCityView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
