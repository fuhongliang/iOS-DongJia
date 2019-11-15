//
//  UAddAddressView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

protocol UAddAddressViewDelegate {
    func chooseAddress()
    func saveAddress(name: String, phone: String, chooseAddress: String, houseNumber: String, isDefalut: Bool)
}

class UAddAddressView: BaseView {
    
    var delegate: UAddAddressViewDelegate?

    let infoBg = UIView().then{
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
        $0.setPlaceholderColor(UIColor.hex(hexString: "#999999"))
    }
    /// 手机号输入框
    let phoneTf = UITextField().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
        $0.placeholder = "请输入手机号码"
        $0.keyboardType = .numberPad
        $0.setPlaceholderColor(UIColor.hex(hexString: "#999999"))
    }
    /// 选择地址按钮
    let chooseBtn = UIButton().then{
        $0.backgroundColor = .white
    }
    /// 选择的城市
    let city = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 15)
        $0.text = "点击选择地址"
    }
    /// 右箭头
    let rightArrow = UIImageView().then{
        $0.image = UIImage.init(named: "right_arrow")
    }
    /// 详细地址输入框
    let houseNumberTf = UITextField().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
        $0.placeholder = "详细地址 例:1号楼103室"
        $0.setPlaceholderColor(UIColor.hex(hexString: "#999999"))
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
    ///设置默认地址的白色背景
    let setDefaultBg = UIView().then{
        $0.backgroundColor = .white
    }
    ///设置默认按钮Label
    let setDefaultLabel = UILabel().then{
        $0.text = "设置默认地址"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    ///switch按钮
    let switchDefaultBtn = UISwitch().then{
        $0.alpha = 1
        $0.onTintColor = .hex(hexString: "#0EC262")
        $0.tintColor = .hex(hexString: "#E4E4E7")
        $0.backgroundColor = .hex(hexString: "#E4E4E7")
        $0.isOn = true
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    ///保存
    let saveBtn = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#0EC262")
        $0.titleLabel?.font = .systemFont(ofSize: 17)
        $0.setTitle("保存", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 22
        $0.layer.masksToBounds = true
    }
    
    override func configUI() {
        //MARK:填写信息白色背景
        self.addSubview(infoBg)
        infoBg.snp.makeConstraints { (make) in
            make.width.top.equalToSuperview()
            make.height.equalTo(179)
        }
        
        //MARK:分割线
        self.addSubview(spaceLine1)
        spaceLine1.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(44)
        }
        
        //MARK:联系人
        self.addSubview(contactLabel)
        contactLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview()
            make.width.equalTo(50)
            make.bottom.equalTo(spaceLine1.snp.top)
        }
        //MARK:联系人输入框
        self.addSubview(contactNameTf)
        contactNameTf.snp.makeConstraints { (make) in
            make.left.equalTo(contactLabel.snp.right).offset(40)
            make.height.equalTo(44)
        }
        
        //MARK:分割线
        self.addSubview(spaceLine2)
        spaceLine2.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(spaceLine1.snp.bottom).offset(44)
        }
        
        //MARK:手机号
        self.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(spaceLine1.snp.bottom)
            make.bottom.equalTo(spaceLine2.snp.top)
        }
        //MARK:手机号输入框
        self.addSubview(phoneTf)
        phoneTf.snp.makeConstraints { (make) in
            make.left.equalTo(contactNameTf)
            make.height.equalTo(44)
            make.top.equalTo(spaceLine1.snp.bottom)
        }
        
        //MARK:分割线
        self.addSubview(spaceLine3)
        spaceLine3.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(spaceLine2.snp.bottom).offset(44)
        }
        
        //MARK:收货地址
        self.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceLine2.snp.bottom)
            make.bottom.equalTo(spaceLine3.snp.top)
            make.left.equalToSuperview().offset(15)
        }
        
        
        //MARK:选择收货地址按钮
        self.addSubview(chooseBtn)
        chooseBtn.snp.makeConstraints { (make) in
            make.left.equalTo(contactNameTf)
            make.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(spaceLine2.snp.bottom)
        }
        chooseBtn.addTarget(self, action: #selector(tapChooseAddress), for: .touchUpInside)
        
        //MARK:点击选择地址
        self.addSubview(city)
        city.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(chooseBtn)
            make.right.equalToSuperview().offset(-26)
        }
        //MARK:右箭头
        self.addSubview(rightArrow)
        rightArrow.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-18)
            make.centerY.equalTo(chooseBtn)
            make.size.equalTo(CGSize(width: 7.75, height: 12.35))
        }
        
        //MARK:门牌号
        self.addSubview(houseNumberLabel)
        houseNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(spaceLine3.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        //MARK:门牌号输入框
        self.addSubview(houseNumberTf)
        houseNumberTf.snp.makeConstraints { (make) in
            make.left.equalTo(contactNameTf)
            make.top.equalTo(spaceLine3.snp.bottom)
            make.height.equalTo(44)
        }
        
       
    }
    
    /// 设置是否有 "设置默认" 选项
    func setHaveDefault(isHiddenDefault: Bool) {
        if (isHiddenDefault) {
            //MARK:设置默认地址的背景
            self.addSubview(setDefaultBg)
            setDefaultBg.snp.makeConstraints { (make) in
                make.top.equalTo(infoBg.snp.bottom).offset(15)
                make.height.equalTo(44)
                make.width.left.equalToSuperview()
            }
            //MARK:设置默认地址label
            setDefaultBg.addSubview(setDefaultLabel)
            setDefaultLabel.snp.makeConstraints { (make) in
                make.left.equalTo(setDefaultBg).offset(15.5)
                make.centerY.equalTo(setDefaultBg)
            }
            //MARK:switch按钮
            setDefaultBg.addSubview(switchDefaultBtn)
            switchDefaultBtn.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-15.5)
                make.centerY.equalTo(setDefaultBg)
            }
        }
        //MARK:保存按钮
        self.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            if (isHiddenDefault) {
                make.top.equalTo(setDefaultBg.snp.bottom).offset(30)
            } else {
                make.top.equalTo(infoBg.snp.bottom).offset(30)
            }
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        saveBtn.addTarget(self, action: #selector(tapSaveAddress), for: .touchUpInside)
    }
    
    @objc func tapChooseAddress() {
        self.endEditing(true)
        delegate?.chooseAddress()
    }
    
    @objc func tapSaveAddress() {
        let name = contactNameTf.text ?? ""
        let phone = phoneTf.text ?? ""
        let chooseAddress = (city.text! == "点击选择地址" ? "" : city.text!)
        let houseNumber = houseNumberTf.text ?? ""
        
        guard name != "" else {
            showHUDInView(text: "收货人不能为空", inView: topVC!.view, isClick: true)
            return
        }
        guard phone.count < 11 else {
            showHUDInView(text: "手机号错误", inView: topVC!.view, isClick: true)
            return
        }
        guard chooseAddress != "" else {
            showHUDInView(text: "请先选择城市地区", inView: topVC!.view, isClick: true)
            return
        }
        guard houseNumber != "" else {
            showHUDInView(text: "详细地址不能为空", inView: topVC!.view, isClick: true)
            return
        }
        
        
        delegate?.saveAddress(name: name, phone: phone, chooseAddress: chooseAddress, houseNumber: houseNumber, isDefalut: switchDefaultBtn.isOn)
    }
    
    var addressInfo: String?{
        didSet{
            guard let addressInfo = addressInfo else { return }
            city.textColor = .black
            city.text = addressInfo
        }
    }
    
}
