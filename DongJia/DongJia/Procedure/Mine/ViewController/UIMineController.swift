//
//  UIMineController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/19.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIMineController: UBaseViewController {

    let mineView = UMineView()
    /// 修改状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{ return .lightContent }
    
    override func configUI() {
        self.view.addSubview(mineView)
        mineView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
