//
//  UContactDesignerView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import UITextView_Placeholder

protocol UContactDesignerViewDelegate {
    func commitMessage(name:String, phone:String, question:String)
}

class UContactDesignerView: BaseView {
    
    var delegate: UContactDesignerViewDelegate?
    
    let bgView = UIView().then{
        $0.backgroundColor = .white
    }
    
    /// 联系人文本
    let contactLabel = UILabel().then{
        $0.text = "联系人"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    /// 联系人名称输入框
    let contactName = UITextField().then{
        $0.placeholder = "请输入您的姓名"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    /// 联系人下面的线
    let contactLine = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#F2F2F2")
    }
    /// 联系电话文本
    let contactPhoneLabel = UILabel().then{
        $0.text = "联系电话"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    /// 联系电话输入框
    let contactPhone = UITextField().then{
        $0.placeholder = "请输入您的联系电话"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.keyboardType = .numberPad
    }
    /// 联系电话下面的线
    let contactPhoneLine = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#F2F2F2")
    }
    
    let question = UITextView().then{
        $0.placeholder = "请填写您的咨询事项，点击留言"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    let commit = UIButton().then{
        $0.layer.cornerRadius = 22
        $0.layer.masksToBounds = true
        $0.backgroundColor = .theme
        $0.setTitle("提交", for: .normal)
        $0.titleLabel?.textColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    override func configUI() {
        
        self.addSubview(bgView)
        bgView.addSubview(contactLabel)
        bgView.addSubview(contactName)
        bgView.addSubview(contactLine)
        bgView.addSubview(contactPhoneLabel)
        bgView.addSubview(contactPhone)
        bgView.addSubview(contactPhoneLine)
        bgView.addSubview(question)
        
        self.addSubview(commit)
        commit.addTarget(self, action: #selector(tapCommitMessageAction), for: .touchUpInside)
        
        //MARK:白色背景
        bgView.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(221)
        }
        //MARK:联系人🧵
        contactLine.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(44)
        }
        //MARK:联系人
        contactLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.bottom.equalTo(contactLine)
        }
        //MARK:联系人输入框
        contactName.snp.makeConstraints { (make) in
            make.centerY.equalTo(contactLabel)
            make.left.equalTo(contactLabel.snp.right).offset(30)
            make.top.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:联系电话🧵
        contactPhoneLine.snp.makeConstraints { (make) in
            make.top.equalTo(contactLine.snp.bottom).offset(44)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(15)
        }
        //MARK:联系电话
        contactPhoneLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(contactLine.snp.bottom)
            make.bottom.equalTo(contactPhoneLine)
        }
        //MARK:联系电话输入框
        contactPhone.snp.makeConstraints { (make) in
            make.centerY.equalTo(contactPhoneLabel)
            make.left.equalTo(contactLabel.snp.right).offset(30)
            make.top.equalTo(contactLine.snp.bottom)
            make.bottom.equalTo(contactPhoneLine)
        }
        
        //MARK:咨询事项
        question.snp.makeConstraints { (make) in
            make.top.equalTo(contactPhoneLine.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        
        //MARK:提交按钮
        commit.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.top.equalTo(bgView.snp.bottom).offset(40)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
    }
    
    @objc func tapCommitMessageAction(){
        let name = String(contactName.text ?? "")
        let phone = String(contactPhone.text ?? "")
        let message = String(question.text ?? "")
        delegate?.commitMessage(name: name, phone: phone, question: message)
    }
    
}
