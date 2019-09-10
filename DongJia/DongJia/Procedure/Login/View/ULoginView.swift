//
//  ULoginView.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

protocol ULoginViewDelegate: AnyObject {
    func okTapAction(phoneNumber: String,password: String)
    func tapGetMsgAction(phoneNumber: String)
    func tapApplyAction()
    func tapManagerDelegate()
}

class ULoginView: BaseView {
    //标题
    var titleLabel = UILabel()
    //字段说明
    var phoneLabel = UILabel()
    
    var pwdLabel = UILabel()
    //手机号和密码
    var phoneNumberEdit = UITextField()
    var pwdEdit = UITextField()
    //分割线
    var phoneLine = UIImageView()
    var pwdLine = UIImageView()
    
    //MARK:说明
    var descrBtn : UIButton = {
        let ub = UIButton()
        ub.tintColor = UIColor.hex(hexString: "#666666")
        let attributed = NSMutableAttributedString()
        var attr = "点击登录及表示同意"
        let target = "《商户端平台管理协议》"
        let blueAttribute = NSMutableAttributedString.init(string: target,attributes: [NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "#1C98F6")])
        let blackAttribute = NSMutableAttributedString.init(string: attr,attributes: [NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "#666666")])
        attributed.append(blackAttribute)
        attributed.append(blueAttribute)
        
        ub.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        ub.setAttributedTitle(attributed, for: .normal)
        return ub
    }()
    
    //登录按钮
    var loginBtn = UIButton()
    
    //申请入驻按钮
    var applyBtn = UIButton()
    
    //获取验证码按钮
    var getMsgBtn = UIButton()
    
    weak var delegate: ULoginViewDelegate?
    
    func setLoginView(passWordLogin:Bool){
        self.backgroundColor = UIColor.white
        //标题
        titleLabel.tintColor = UIColor.black
        titleLabel.text = "密码登录"
        titleLabel.font = UIFont.systemFont(ofSize: 28)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalToSuperview().offset(118)
            ConstraintMaker.centerX.equalToSuperview()
            ConstraintMaker.height.equalTo(27)
        }
        
        //手机号
        phoneLabel.tintColor = UIColor.black
        phoneLabel.text = "手机号"
        phoneLabel.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(titleLabel.snp.bottom).offset(45)
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.height.equalTo(50)
        }
        
        phoneNumberEdit.tintColor = UIColor.hex(hexString: "#999999")
        phoneNumberEdit.textColor = UIColor.black
        phoneNumberEdit.placeholder = "请输入手机号"
        phoneNumberEdit.font = UIFont.systemFont(ofSize: 17)
        phoneNumberEdit.keyboardType = UIKeyboardType.numberPad
        self.addSubview(phoneNumberEdit)
        phoneNumberEdit.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(titleLabel.snp.bottom).offset(45)
            ConstraintMaker.right.equalToSuperview()
            ConstraintMaker.left.equalToSuperview().offset(63)
            ConstraintMaker.height.equalTo(50)
        }
        
        //分割线
        phoneLine.backgroundColor = UIColor.hex(hexString: "#CCCCCC")
        self.addSubview(phoneLine)
        phoneLine.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(phoneNumberEdit.snp.bottom)
            ConstraintMaker.right.equalToSuperview()
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.height.equalTo(1)
        }
        
        //密码
        pwdLabel.text = "密   码"
        pwdLabel.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(pwdLabel)
        pwdLabel.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(phoneLine.snp.bottom).offset(10)
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.height.equalTo(50)
        }
        
        //获取验证码按钮
        getMsgBtn.backgroundColor = UIColor.white
        getMsgBtn.setTitleColor(UIColor.theme, for: UIControl.State.normal)
        getMsgBtn.setTitle("获取验证码", for: UIControl.State.normal)
        getMsgBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        getMsgBtn.sizeToFit()
        self.addSubview(getMsgBtn)
        getMsgBtn.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(phoneLine.snp.bottom).offset(10)
            ConstraintMaker.right.equalToSuperview()
            ConstraintMaker.height.equalTo(50)
        }
        //输入密码框
        pwdEdit.tintColor = UIColor.hex(hexString: "#999999")
        pwdEdit.textColor = UIColor.black
        pwdEdit.placeholder = "请输入密码"
        pwdEdit.font = UIFont.systemFont(ofSize: 17)
        pwdEdit.isSecureTextEntry = true
        self.addSubview(pwdEdit)
        pwdEdit.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(phoneLine.snp.bottom).offset(10)
            ConstraintMaker.left.equalToSuperview().offset(63)
            ConstraintMaker.right.equalTo(getMsgBtn.snp.left)
            ConstraintMaker.height.equalTo(50)
        }
        
        
        //分割线
        pwdLine.backgroundColor = UIColor.hex(hexString: "#CCCCCC")
        self.addSubview(pwdLine)
        pwdLine.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(pwdEdit.snp.bottom)
            ConstraintMaker.right.equalToSuperview()
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.height.equalTo(1)
        }

        //MARK:说明Button
        self.addSubview(descrBtn)
        descrBtn.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(pwdLine.snp.bottom).offset(15)
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.height.equalTo(14)
        }
        descrBtn.addTarget(self, action: #selector(tapManagerDelegate), for: UIControl.Event.touchUpInside)
        
        //登录按钮
        loginBtn.backgroundColor = UIColor.hex(hexString: "#1C98F6")
        loginBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        loginBtn.setTitle("登录", for: UIControl.State.normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 3
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(descrBtn.snp.bottom).offset(51)
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.right.equalToSuperview()
            ConstraintMaker.height.equalTo(44)
        }
        
        //申请入驻按钮
        
        applyBtn.backgroundColor = UIColor.hex(hexString: "#F0F0F0")
        applyBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        applyBtn.setTitle("申请入驻", for: UIControl.State.normal)
        applyBtn.layer.masksToBounds = true
        applyBtn.layer.cornerRadius = 3
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        self.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(loginBtn.snp.bottom).offset(15)
            ConstraintMaker.left.equalToSuperview()
            ConstraintMaker.right.equalToSuperview()
            ConstraintMaker.height.equalTo(44)
        }
        
        if (passWordLogin){
            titleLabel.text = "密码登录"
            pwdLabel.text = "密   码"
            pwdEdit.placeholder = "请输入密码"
            getMsgBtn.setTitle("", for: UIControl.State.normal)
        }else{
            titleLabel.text = "验证码登录"
            pwdLabel.text = "验证码"
            pwdEdit.placeholder = "请输入验证码"
            getMsgBtn.setTitle("获取验证码", for: UIControl.State.normal)
        }
        
        loginBtn.addTarget(self, action: #selector(okTapAction), for: UIControl.Event.touchUpInside)
        
        getMsgBtn.addTarget(self, action: #selector(tapGetMsgAction), for: UIControl.Event.touchUpInside)
        
        applyBtn.addTarget(self, action: #selector(tapApplyAction), for: UIControl.Event.touchUpInside)
        
    }
    
    @objc func okTapAction() {
        delegate?.okTapAction(phoneNumber: phoneNumberEdit.text!,password:pwdEdit.text!)
    }
    
    @objc func tapGetMsgAction() {
        delegate?.tapGetMsgAction(phoneNumber: phoneNumberEdit.text!)
    }
    
    @objc func tapApplyAction() {
        delegate?.tapApplyAction()
    }
    
    @objc func tapManagerDelegate() {
        delegate?.tapManagerDelegate()
    }
}

