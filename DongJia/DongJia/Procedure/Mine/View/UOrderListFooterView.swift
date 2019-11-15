//
//  UOrderListFooterView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit

class UOrderListFooterView: BaseView {
    
    var cancleOrderAction: (()->())?
    var buyNowAction: (()->())?
    var deleteOrderAction: (()->())?
    var contactMchAction: (()->())?
    var confirmObtainAction: (()->())?

    /// 商品信息下的线
    let line = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    let view = UIView().then{
        $0.backgroundColor = .white
    }
    
    /// 取消订单
    let cancleOrder = QMUIGhostButton().then{
        $0.ghostColor = .hex(hexString: "#E6E6E6")
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("取消订单", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize:13)
    }
    
    /// 立即支付
    let buyNow = QMUIGhostButton().then{
        $0.ghostColor = .theme
        $0.setTitle("立即支付", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize:13)
    }
    /// 取消订单
    let deleteOrder = QMUIGhostButton().then{
        $0.ghostColor = .hex(hexString: "#E6E6E6")
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("删除订单", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize:13)
    }
    /// 联系卖家
    let contactMch = QMUIGhostButton().then{
        $0.ghostColor = .hex(hexString: "#E6E6E6")
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("联系卖家", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize:13)
    }
    /// 确认收货
    let confirmObtain = QMUIGhostButton().then{
        $0.ghostColor = .theme
        $0.setTitle("确认收货", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize:13)
    }
    override func configUI() {
        view.addSubview(line)
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.width.left.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:线
        line.snp.makeConstraints { (make) in
            make.width.left.top.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    /// 待付款
    func notPay(){
        view.addSubview(cancleOrder)
        view.addSubview(buyNow)
        cancleOrder.addTarget(self, action: #selector(tapCancleOrder), for: .touchUpInside)
        buyNow.addTarget(self, action: #selector(tapBuyNow), for: .touchUpInside)
        //MARK:立即支付
        buyNow.snp.makeConstraints { (make) in
//            make.top.equalTo(line.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 84,height: 26))
            make.right.equalToSuperview().offset(-12)
//            make.bottom.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        //MARK:取消订单
        cancleOrder.snp.makeConstraints { (make) in
//            make.top.equalTo(line.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 84,height: 26))
            make.right.equalTo(buyNow.snp.left).offset(-12)
//            make.bottom.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    /// 待发货
    func notReceipt(){
        view.addSubview(cancleOrder)
        view.addSubview(contactMch)
        cancleOrder.addTarget(self, action: #selector(tapCancleOrder), for: .touchUpInside)
        contactMch.addTarget(self, action: #selector(tapContactMch), for: .touchUpInside)
        //MARK:联系卖家
        contactMch.snp.makeConstraints { (make) in
//            make.top.equalTo(line.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 84,height: 26))
            make.right.equalToSuperview().offset(-12)
//            make.bottom.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        //MARK:取消订单
        cancleOrder.snp.makeConstraints { (make) in
//            make.top.equalTo(line.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 84,height: 26))
            make.right.equalTo(contactMch.snp.left).offset(-12)
//            make.bottom.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    /// 待收货
    func notObtain(){
        view.addSubview(confirmObtain)
        confirmObtain.addTarget(self, action: #selector(tapConfirmObtain), for: .touchUpInside)
        //MARK:确认收货
        confirmObtain.snp.makeConstraints { (make) in
//            make.top.equalTo(line.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 84,height: 26))
            make.right.equalToSuperview().offset(-12)
//            make.bottom.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    /// 已完成/已取消
    func completeOrCancle(){
        view.addSubview(deleteOrder)
        deleteOrder.addTarget(self, action: #selector(tapDeleteOrder), for: .touchUpInside)
        //MARK:确认收货
        deleteOrder.snp.makeConstraints { (make) in
//            make.top.equalTo(line.snp.bottom).offset(15)
            make.size.equalTo(CGSize(width: 84,height: 26))
            make.right.equalToSuperview().offset(-12)
//            make.bottom.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func tapCancleOrder(){
        cancleOrderAction?()
    }
    @objc func tapDeleteOrder(){
        deleteOrderAction?()
    }
    @objc func tapBuyNow(){
        buyNowAction?()
    }
    @objc func tapContactMch(){
        contactMchAction?()
    }
    @objc func tapConfirmObtain(){
        confirmObtainAction?()
    }
    
    var state: OrderType?{
        didSet{
            guard let state = state else { return }
            switch state {
            case .Cancle,.Complete,.Sales:
                completeOrCancle()
            case .NotPay:
                notPay()
            case .NotObtain:
                notObtain()
            case .NotReceipt:
                notReceipt()
            default:
                break
            }
        }
    }
    
}
