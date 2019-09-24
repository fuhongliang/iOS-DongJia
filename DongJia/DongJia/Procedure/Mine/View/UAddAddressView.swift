//
//  UAddAddressView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UAddAddressView: BaseView {

    
    let infoBg = UIView().then{
        $0.backgroundColor = .white
    }
    
    let setDefaltBg = UIView().then{
        $0.backgroundColor = .white
    }
    
    /// 联系人label
    let contactLabel =  UILabel().then{
        $0.text = "联系人"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 手机号label
    let phoneLabel =  UILabel().then{
        $0.text = "手机号"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 城市地区label
    let cityLabel =  UILabel().then{
        $0.text = "收货地址"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 详细地址label
    let houseNumberLabel =  UILabel().then{
        $0.text = "门牌号"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 收货人姓名输入框
    let contactNameTf = UITextField().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
        $0.placeholder = "请输入收货人姓名"
    }
    /// 手机号输入框
    let phoneTf = UITextField().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
        $0.placeholder = "请输入手机号码"
    }
    /// 选择地址按钮
    let chooseBtn = UIButton().then{
        $0.backgroundColor = .white
    }
    let city = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 15)
        $0.text = "点击选择地址"
    }
    let rightArrow = UIImageView().then{
        $0.image = UIImage.init(named: "right_arrow")
    }
    /// 详细地址输入框
    let houseNumberTf = UITextField().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
        $0.placeholder = "详细地址 例:1号楼103室"
    }
    ///分割线
    let spaceLine1 = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F0F0F0")
    }
    ///分割线
    let spaceLine2 = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F0F0F0")
    }
    ///分割线
    let spaceLine3 = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F0F0F0")
    }
    ///保存
    let saveBtn = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#0EC262")
        $0.titleLabel?.font = .systemFont(ofSize: 17)
        $0.setTitle("保存", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    override func configUI() {
        
        //MARK:填写信息白色背景
        infoBg.snp.makeConstraints { (make) in
            make.width.top.equalToSuperview()
        }
        //MARK:联系人
        contactLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        //MARK:联系人输入框
        contactNameTf.snp.makeConstraints { (make) in
            make.left.equalTo(contactLabel.snp.right).offset(40)
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:分割线
        spaceLine1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(contactNameTf.snp.bottom)
        }
        
        //MARK:手机号
        contactLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        //MARK:手机号输入框
        contactNameTf.snp.makeConstraints { (make) in
            make.left.equalTo(contactLabel.snp.right).offset(40)
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:分割线
        spaceLine1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(contactNameTf.snp.bottom)
        }
        
        //MARK:收货地址
        contactLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        //MARK:选择收货地址按钮
        contactNameTf.snp.makeConstraints { (make) in
            make.left.equalTo(contactLabel.snp.right).offset(40)
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        // TODO 选择地址 and 箭头
        
        //MARK:分割线
        spaceLine1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(contactNameTf.snp.bottom)
        }
        
        //MARK:门牌号
        contactLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        //MARK:门牌号输入框
        contactNameTf.snp.makeConstraints { (make) in
            make.left.equalTo(contactLabel.snp.right).offset(40)
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:分割线
        spaceLine1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(0.5)
            make.centerX.equalToSuperview()
            make.top.equalTo(contactNameTf.snp.bottom)
        }
        
    }
    
}
