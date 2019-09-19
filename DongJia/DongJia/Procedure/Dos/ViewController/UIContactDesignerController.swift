//
//  UIContactDesignerController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIContactDesignerController: UBaseViewController {
    
    var designerView = UContactDesignerView()
    
    override func configUI() {
        self.view.addSubview(designerView)
        designerView.delegate = self
        designerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension UIContactDesignerController: UContactDesignerViewDelegate{
    func commitMessage(name: String, phone: String, question: String) {
        if name == "" || phone == "" {
            showHUDInView(text: "请完善联系方式", inView: self.view)
            return
        }
        
        showAlert(title: "提交成功", subTitle: "name:\(name) \n phone:\(phone) \n message:\(question) \n 请保持电话通畅,设计师将与您电话联系"){ (alert) in
            alert.addButton("知道了", textColor: .theme){
                self.pressBack()
            }
        }
        
    }
    
}
