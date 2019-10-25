//
//  UConfirmOrderAddressCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UConfirmOrderAddressCell: UBaseTableViewCell {

    let view = ArcView().then{
        $0.fillColor = .theme
        $0.arcHeight = 80
        $0.backgroundColor = .background
    }
    
    /// 白色背景
    let whiteBg = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    /// 定位图标
    let gpsIcon = UIImageView().then{
        $0.image = UIImage.init(named: "gps_img")
    }
    /// 收货人名称
    let consigneeName = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 17)
    }
    /// 收货人电话
    let consigneePhone = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 17)
    }
    /// 收货人地址
    let consigneeAddress = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 13)
    }
    /// 右箭头
    let rightArrow = UIImageView().then{
        $0.image = UIImage.init(named: "right_arrow")
    }
    
    override func configUI() {
        consigneeName.text = "于亿鑫"
        consigneePhone.text = "13265345992"
        consigneeAddress.text = "广东省深圳市宝安区新安三路28号16楼1610"
        contentView.addSubview(view)
        contentView.addSubview(whiteBg)
        whiteBg.addSubview(gpsIcon)
        whiteBg.addSubview(consigneeName)
        whiteBg.addSubview(consigneePhone)
        whiteBg.addSubview(consigneeAddress)
        whiteBg.addSubview(rightArrow)
        
        view.snp.makeConstraints { (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalTo(70)
        }
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(15)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(70)
            make.bottom.centerX.equalToSuperview()
        }
        //MARK:定位图标
        gpsIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 14.5, height: 19))
        }
        //MARK:收货人名称
        consigneeName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(13)
            make.left.equalTo(gpsIcon.snp.right).offset(20)
        }
        //MARK:收货人电话
        consigneePhone.snp.makeConstraints { (make) in
            make.top.equalTo(consigneeName)
            make.left.equalTo(consigneeName.snp.right).offset(30)
        }
        //MARK:收货人地址
        consigneeAddress.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-13)
            make.left.equalTo(gpsIcon.snp.right).offset(20)
            make.right.equalToSuperview().offset(-25)
        }
        //MARK:右箭头
        rightArrow.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 8, height: 12.5))
        }
    }
    
    var addressData: submit_view_address_model? {
        didSet{
            guard let address = addressData else { return }
            consigneeName.text = address.name
            consigneePhone.text = address.mobile
            consigneeAddress.text = "\(address.province)\(address.city)\(address.district)\(address.detail)"
        }
    }

}
