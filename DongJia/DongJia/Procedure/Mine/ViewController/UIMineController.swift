//
//  UIMineController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/19.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit

class UIMineController: UBaseViewController {
    
    private var loginService = APIUserServices()
    private var mineService = APIMineServices()
    
    var mineData: mine_model?
    
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
        refreshUserData()
    }
    
    func refreshUserData(){
        // 判断当前已经登录 就把保存的登录状态赋值
        if APIUser.shared.user != nil {
            mineView.loginData = APIUser.shared.user
            mineService.getMineData({ (MineData) in
                self.mineData = MineData.data
            }) { (APIErrorModel) in
                
            }
        }
    }
}
extension UIMineController: UMineViewDelegate {
    func myAllOrder() {
        let vc = UManagerOrdersController()
        vc.title = "全部订单"
        pushViewController(vc, animated: true)
    }
    
    func wechatLogin() {
        if !WXApi.isWXAppInstalled() {
            showHUDInView(text: "还未安装微信,请先安装", inView: self.view)
            return
        }
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "dongjia_wechat_login_request"
        WXApi.send(req)
        print("----微信请求信息----")
    }
    
    func logout() {
        let alert = QMUIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionLogout = QMUIAlertAction.init(title: "退出登录", style: .default) { (_, _) in
            self.mineView.loginData = nil
            APIUser.shared.cleanUser()
        }
        
        let action = QMUIAlertAction.init(title: "取消", style: .cancel) { (_, _) in}
        alert.addAction(action)
        alert.addAction(actionLogout)
        alert.showWith(animated: true)
        
    }
    
    func notPayOrder() {
        let vc = UOrderListController()
        vc.title = "待付款订单"
        vc.orderType = OrderType.NotPay
        pushViewController(vc, animated: true)
    }
    
    func notSendOrder() {
        let vc = UOrderListController()
        vc.title = "待发货订单"
        vc.orderType = OrderType.NotReceipt
        pushViewController(vc, animated: true)
    }
    
    func notObtainOrder() {
        let vc = UOrderListController()
        vc.title = "待收货订单"
        vc.orderType = OrderType.NotObtain
        pushViewController(vc, animated: true)
    }
    
    func completeOrder() {
        let vc = UOrderListController()
        vc.title = "已完成订单"
        vc.orderType = OrderType.Complete
        pushViewController(vc, animated: true)
    }
    
    func myCoupon(){
        showHUDInView(text: "我的优惠券", inView: self.view, isClick: true)
    }
    
    func myAfterSales() {
        showHUDInView(text: "我的售后", inView: self.view, isClick: true)
        let vc = UOrderListController()
        vc.title = "我的售后订单"
        vc.orderType = OrderType.Sales
        pushViewController(vc, animated: true)
    }
    
    func myCollection() {
        let vc = UIMyCollectionController()
        vc.title = "我的收藏"
        pushViewController(vc, animated: true)
    }
    
    func obtainAddress() {
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
