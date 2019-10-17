//
//  ULoginViewController.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit
import MBProgressHUD

/// isClick true 点击 false 不能点击
public func showHUDInView(text: String, inView: UIView, isClick:Bool = false) {
    let hud = MBProgressHUD.showAdded(to: inView, animated: true)
    hud.mode = MBProgressHUDMode.text
    hud.label.text = text
    hud.isUserInteractionEnabled = !isClick
    hud.hide(animated: true, afterDelay: 2.0)
}

class ULoginViewController: UBaseViewController {

    fileprivate var service: APIUserServices = APIUserServices()

    let loginView = ULoginView()

    var passWordLogin = true

    var loginStyle = "验证码登录"

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //MARK:重写顶部导航栏
//    override func configNavigationBar() {
//        guard let navi = navigationController else { return }
//        if navi.visibleViewController == self {
//            navi.barStyle(.clear)
//            let btnItem = UIBarButtonItem.init(title: loginStyle, style: .plain, target: self, action: #selector(tapChangeLoginStyleAction))
//            btnItem.tintColor = UIColor.black
//            btnItem.setBackgroundImage(UIColor.white.image(), for: .normal, barMetrics: .default)
//            btnItem.width = 80
//            navigationItem.rightBarButtonItem = btnItem
//        }
//    }
    //MARK:初始化视图
    override func configUI() {
        
        loginView.setLoginView(passWordLogin: passWordLogin)
        loginView.delegate = self

        self.view.addSubview(loginView)
        self.view.backgroundColor = UIColor.white

        loginView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        }
    }
    //MARK:切换登录方式
    @objc func tapChangeLoginStyleAction() {
        passWordLogin = !passWordLogin
        if(passWordLogin){
            loginStyle = "验证码登录"
        }else{
            loginStyle = "密码登录"
        }
//        configNavigationBar()
        configUI()
    }

    //MARK:倒计时
    func startTimer() {
        var timeCount = 60
        // 在global线程里创建一个时间源
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        // 设定这个时间源是每秒循环一次，立即开始
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        timer.setEventHandler(handler: {
            // 每秒计时一次
            timeCount = timeCount - 1
            // 时间到了取消时间源
            if timeCount <= 0 {
                timer.cancel()
                DispatchQueue.main.async {
                    //重置
                    self.loginView.getMsgBtn.setTitle("获取验证码", for: UIControl.State.normal)
                }

            }
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                self.loginView.getMsgBtn.setTitle(String (timeCount) + "S重新获取", for: UIControl.State.normal)
            }
        })
        // 启动时间源
        timer.resume()
    }

}



extension ULoginViewController: ULoginViewDelegate {
    
    func tapManagerDelegate() {
//        let vc = UPlatformManagerDelegateController()
//        vc.title = "商户平台管理协议"
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tapGetMsgAction(phoneNumber: String) {
        guard phoneNumber.count > 0 else {
            showHUDInView(text: "请输入手机号码", inView: view)
            return
        }
        
//        service.getLoginMsg(phoneNumber: phoneNumber, { (APIListModel) in
//            showHUDInView(text: "获取验证码成功", inView: self.view)
//            self.startTimer()
//        }, { (APIErrorModel) in
//            showHUDInView(text: APIErrorModel.msg ?? "获取验证码失败", inView: self.view)
//        })
    }

    //MARK:申请入驻
    func tapApplyAction() {
//        let vc = UMechJoinViewController()
//        vc.title = "申请入驻"
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    func okTapAction(phoneNumber: String, password: String) {
        guard phoneNumber.count > 0 else {
            showHUDInView(text: "请输入手机号码", inView: view)
            return
        }

        guard password.count > 0 else {
            showHUDInView(text: "请输入密码或者验证码", inView: view)
            return
        }

//        service.login(phoneNumber: phoneNumber, password: password, jpush_registration_id: getJPushRegistrationID(), { (APILoginResponseModel) in
//            let rootVC = UIApplication.shared.delegate as! AppDelegate
//            rootVC.window?.rootViewController = UTabBarController()
//        }) { (APIErrorModel) in
//            showHUDInView(text: APIErrorModel.msg ?? "登录失败", inView: self.view)
//        }
    }
}


