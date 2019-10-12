//
//  UIStoreControlle.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIStoreController: UBaseViewController {
    private let service = APIStoreService()
    var v = UStoreInfoView()
    /// 店家数据
    var storeInfoData: store_info_model?
    /// 店家精品案例
    var storeClassicCaseData: [store_classic_case_model] = []
    /// 店铺ID
    var storeId: String = "0"
    override func configUI() {
        
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        getStoreInfo()
    }
    /// 获取商家主页数据
    func getStoreInfo(){
        
        service.getStoreInfo(mchId: storeId, page: "1", { (StoreInfoData) in
            self.storeInfoData = StoreInfoData.data
//            self.cells = [.storeInfo,.hotRecommend,.willBuy]
            self.v.setData(storeInfoData: self.storeInfoData)
            //请求精品案例数据
            self.getStoreClassicCase()
        }) { (APIErrorModel) in
            
        }
    }
    /// 获取商家精品案例数据
    func getStoreClassicCase(){
        service.getStoreClassicCase(mchId: storeId, { (StoreClassicCaseData) in
            self.storeClassicCaseData = StoreClassicCaseData.data ?? []
            self.v.setCData(storeClassicCaseData: self.storeClassicCaseData)
        }) { (APIErrorModel) in
            
        }
    }
}
