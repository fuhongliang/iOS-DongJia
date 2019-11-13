//
//  UOrderListHeaderView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UOrderListHeaderView: BaseView {

    let view = UIView()
    /// 商家图片
    let mchPic = UIImageView().then{
        $0.backgroundColor = .random
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    /// 商家名称
    let mchName = UILabel().then{
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    /// 订单状态
    let orderState = UILabel().then{
        $0.text = "待付款"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .hex(hexString: "#F51616")
    }
    
    override func configUI() {
        backgroundColor = .white
        addSubview(view)
        view.addSubview(mchPic)
        view.addSubview(mchName)
        view.addSubview(orderState)
        
        view.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: screenWidth, height: 44))
            make.left.top.equalToSuperview()
        }
        //MARK:商家图片
        mchPic.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        //MARK:商家名称
        mchName.snp.makeConstraints { (make) in
            make.centerY.equalTo(mchPic)
            make.left.equalTo(mchPic.snp.right).offset(7)
        }
        //MARK:订单状态
        orderState.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(mchPic)
        }
        
        
    }
    
    var state: OrderType? = .All {
        didSet{
            guard let state = state else { return }
            switch state {
            case .Cancle:
                orderState.text = "已取消"
                orderState.textColor = .hex(hexString: "#999999")
            case .NotPay:
                orderState.text = "待付款"
                orderState.textColor = .hex(hexString: "#F51616")
            case .NotReceipt:
                orderState.text = "待发货"
                orderState.textColor = .hex(hexString: "#FF7B1B")
            case .NotObtain:
                orderState.text = "待收货"
                orderState.textColor = .hex(hexString: "#4B93FE")
            case .Complete:
                orderState.text = "已完成"
                orderState.textColor = .hex(hexString: "#0EC262")
            default: break
            }
        }
    }

    /// 商家信息
    var mch: mch_model?{
        didSet{
            guard let mch = mch else { return }
            mchPic.load(mch.logo)
            mchName.text = mch.name
        }
    }
}
