//
//  UObtainAddressCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UObtainAddressCell: UBaseTableViewCell {
    
    var setDefaultAddress: (() -> ())?
    var editAddress: (() -> ())?
    var deleteAddress: (() -> ())?

    /// 收货人名称
    let obtainPeopleName = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 收货人电话
    let obtainPeoplePhone = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 收获地址
    let obtainAddress = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 13)
        $0.numberOfLines = 0
    }
    /// 分割线
    let spaceLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    /// 设置默认地址按钮
    let setDefaultBtn = UIButton().then{
        $0.setImage(UIImage.init(named: "select_default_address"), for: .selected)
        $0.setImage(UIImage.init(named: "not_select_default_address"), for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.setTitle("设为默认地址", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.backgroundColor = .white
        $0.layoutButton(style: .Left, imageTitleSpace: 10)
    }
    /// 编辑地址按钮
    let editAddressBtn = UIButton().then{
        $0.setImage(UIImage.init(named: "edit_address"), for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.setTitle("编辑", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.backgroundColor = .white
        $0.layoutButton(style: .Left, imageTitleSpace: 10)
    }
    /// 删除地址按钮
    let deleteAddressBtn = UIButton().then{
        $0.setImage(UIImage.init(named: "delete_address"), for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.setTitle("删除", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.backgroundColor = .white
        $0.layoutButton(style: .Left, imageTitleSpace: 10)
    }
    
    override func configUI() {
        
        self.addSubview(obtainPeopleName)
        self.addSubview(obtainPeoplePhone)
        self.addSubview(obtainAddress)
        self.addSubview(spaceLine)
        self.addSubview(setDefaultBtn)
        self.addSubview(editAddressBtn)
        self.addSubview(deleteAddressBtn)
        setDefaultBtn.addTarget(self, action: #selector(tapSetDefaultAddress), for: .touchUpInside)
        editAddressBtn.addTarget(self, action: #selector(tapEditAddress), for: .touchUpInside)
        deleteAddressBtn.addTarget(self, action: #selector(tapDeleteAddress), for: .touchUpInside)
        
        //MARK:收货人名称
        obtainPeopleName.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        //MARK:收货人电话
        obtainPeoplePhone.snp.makeConstraints { (make) in
            make.left.equalTo(obtainPeopleName.snp.right).offset(33)
            make.centerY.equalTo(obtainPeopleName)
        }
        //MARK:收货地址
        obtainAddress.snp.makeConstraints { (make) in
            make.left.equalTo(obtainPeopleName)
            make.top.equalTo(obtainPeopleName.snp.bottom).offset(12)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:分割线
        spaceLine.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(obtainAddress.snp.bottom).offset(15)
        }
        //MARK:设为默认地址
        setDefaultBtn.snp.makeConstraints { (make) in
            make.left.equalTo(obtainPeopleName)
            make.top.equalTo(spaceLine)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        //MARK:删除
        deleteAddressBtn.snp.makeConstraints { (make) in
            make.top.right.equalTo(spaceLine)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        //MARK:编辑
        editAddressBtn.snp.makeConstraints { (make) in
            make.right.equalTo(deleteAddressBtn.snp.left).offset(-20)
            make.top.equalTo(spaceLine)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
    }
    
    @objc func tapSetDefaultAddress(){
        setDefaultAddress?()
    }
    @objc func tapEditAddress(){
        editAddress?()
    }
    @objc func tapDeleteAddress(){
        deleteAddress?()
    }
    
    var model: address_model? {
        didSet{
            guard let model = model else { return }
            setDefaultBtn.isSelected = model.is_default == "1"
            obtainPeopleName.text = model.name
            obtainPeoplePhone.text = model.mobile
            obtainAddress.text = "\(model.address!)"
        }
    }
    
}
