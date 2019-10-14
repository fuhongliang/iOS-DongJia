//
//  UISearchController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UISearchController: UBaseViewController {
    
    let searchView = USearchView()
    
    override func configUI() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
