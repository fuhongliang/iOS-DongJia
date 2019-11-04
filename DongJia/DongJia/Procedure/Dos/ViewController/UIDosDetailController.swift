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
    
    private let service = APIDosServices()
    
    var dosCaseId = "0"

    override func configUI() {
        self.view.addSubview(dosDetail)
        dosDetail.delegate = self
        dosDetail.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        getDosDetail()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    /// 获取详情
    func getDosDetail(){
        service.getDosCaseDetail(id: dosCaseId, { (CaseDetailModel) in
            self.dosDetail.model = CaseDetailModel.data
        }) { (APIErrorModel) in
            
        }
    }
    
}
extension UIDosDetailController: UDosDetailViewDelegate{
    func goBack() {
        pressBack()
    }
    
    func contactDesignerAction() {
        checkLoginState {
            let vc = UIContactDesignerController()
            vc.title = "联系设计师"
            vc.topicId = dosCaseId
            pushViewController(vc, animated: true)
        }
        
    }
}
