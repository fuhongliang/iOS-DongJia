//
//  UStoreInfoView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UStoreInfoView: BaseView {
    let scrollView = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false //是否显示滚动条
        $0.backgroundColor = .background
        $0.bounces = true //设置是否可以拉出空白区域
        $0.isScrollEnabled = true //设置允许滑动
    }
    let storeMainInfoView = UStoreMainInfoView()
    let storeHotRecommendView = UStoreHotRecommendView()
    let storeClassicCaseView = UStoreClassicCaseView()
    let storeWillBuyView = UStoreWillBuyView()
    override func configUI() {
        
        self.backgroundColor = .background
        self.addSubview(scrollView)
        scrollView.addSubview(storeMainInfoView)
        scrollView.addSubview(storeHotRecommendView)
        scrollView.addSubview(storeClassicCaseView)
        scrollView.addSubview(storeWillBuyView)
        
        //MARK:scrollView
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        storeMainInfoView.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
        }
        storeMainInfoView.moreInfoBtnAction = { (isOpen) in
            UIView.animate(withDuration: 0.5) {
                self.storeMainInfoView.brandInfo.numberOfLines = isOpen ? 0 : 3
                self.layoutIfNeeded()
            }
        }
        
        storeHotRecommendView.snp.makeConstraints { (make) in
            make.top.equalTo(storeMainInfoView.snp.bottom)
            make.width.equalToSuperview()
        }
        storeClassicCaseView.snp.makeConstraints { (make) in
            make.top.equalTo(storeHotRecommendView.snp.bottom)
            make.width.equalToSuperview()
        }
        storeWillBuyView.snp.makeConstraints { (make) in
            make.top.equalTo(storeClassicCaseView.snp.bottom)
            make.width.bottom.equalToSuperview()
        }
        
    }

    func setData(storeInfoData: store_info_model?){
        guard let storeInfoData = storeInfoData else { return }
        storeMainInfoView.storeInfo = storeInfoData.shop
        storeHotRecommendView.data = storeInfoData.recommend_list
        
        storeWillBuyView.data = storeInfoData.goods_list
    }
    func setCData(storeClassicCaseData: [store_classic_case_model]){
        storeClassicCaseView.data = storeClassicCaseData
        if storeClassicCaseData.isEmpty {
            storeClassicCaseView.removeFromSuperview()
            storeWillBuyView.snp.makeConstraints { (make) in
                make.top.equalTo(storeHotRecommendView.snp.bottom)
                make.width.bottom.equalToSuperview()
            }
        }
    }
}
