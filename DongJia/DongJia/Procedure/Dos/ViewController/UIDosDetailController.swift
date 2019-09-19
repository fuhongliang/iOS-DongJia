//
//  UIDosDetailController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIDosDetailController: UBaseViewController {
    
    var dosDetail = UDosDetailView()

    override func configUI() {
        self.view.addSubview(dosDetail)
        dosDetail.delegate = self
        dosDetail.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
extension UIDosDetailController: UDosDetailViewDelegate{
    func goBack() {
        pressBack()
    }
    
    func contactDesignerAction() {
        let vc = UIContactDesignerController()
        vc.title = "联系设计师"
        pushViewController(vc, animated: true)
    }
}
