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
        mineView.delegate = self
        mineView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
extension UIMineController: UMineViewDelegate {
    func myAllOrder() {
        showHUDInView(text: "全部订单", inView: self.view, isClick: true)
    }
    
    func wechatLogin() {
        showHUDInView(text: "微信登录", inView: self.view, isClick: true)
    }
    
    func logout() {
        showHUDInView(text: "退出登录", inView: self.view, isClick: true)
    }
    
    func notPayOrder() {
        showHUDInView(text: "待付款订单", inView: self.view, isClick: true)
    }
    
    func notSendOrder() {
        showHUDInView(text: "待发货订单", inView: self.view, isClick: true)
    }
    
    func notObtainOrder() {
        showHUDInView(text: "待收货订单", inView: self.view, isClick: true)
    }
    
    func completeOrder() {
        showHUDInView(text: "已完成订单", inView: self.view, isClick: true)
    }
    
    func myAfterSales() {
        showHUDInView(text: "我的售后", inView: self.view, isClick: true)
    }
    
    func myCollection() {
        let vc = UIMyCollectionController()
        vc.title = "我的收藏"
        pushViewController(vc, animated: true)
    }
    
    func obtainAddress() {
//        showHUDInView(text: "收货地址", inView: self.view, isClick: true)
        let vc = UIMyObtainAddressViewController()
        vc.title = "我的收货地址"
        pushViewController(vc, animated: true)
    }
    
    func aboutOus() {
        let vc = UIAboutUsController()
        vc.title = "关于我们"
        pushViewController(vc, animated: true)
    }
    
    
}
