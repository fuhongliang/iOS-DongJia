//
//  UIMineController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/19.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIMineController: UBaseViewController {
    
    private var service = APIUserServices()
    
    let mineView = UMineView()
    /// 修改状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{ return .lightContent }
    
    override func configUI() {
        //注册通知--用于接收微信登录的返回的code
        NotificationCenter.default.addObserver(self, selector: #selector(WXLoginSuccess(_:)), name: Notification.Name.weChatLoginNotification, object: nil)
        
        self.view.addSubview(mineView)
        mineView.delegate = self
        mineView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        // 判断当前已经登录 就把保存的登录状态赋值
        if APIUser.shared.user != nil {
            mineView.loginData = APIUser.shared.user
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func WXLoginSuccess(_ notification: Notification){
        let code = notification.object as! String
        print("微信返回的Code----\(code)")
        service.login(wxCode: code, { (APILoginResponseModel) in
            self.mineView.loginData = APILoginResponseModel.data
        }) { (APIErrorModel) in
            
        }
    }

}
extension UIMineController: UMineViewDelegate {
    func myAllOrder() {
        showHUDInView(text: "全部订单", inView: self.view, isClick: true)
    }
    
    func wechatLogin() {
        if WXApi.isWXAppInstalled() {
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
        mineView.loginData = nil
        APIUser.shared.cleanUser()
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
