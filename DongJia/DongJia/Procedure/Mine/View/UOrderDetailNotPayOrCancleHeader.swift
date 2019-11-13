//
//  UOrderDetailNotPayOrCancleHeader.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/13.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UOrderDetailNotPayOrCancleHeader: BaseView {
    
    let view = UIView().then{
        $0.backgroundColor = .white
    }
    
    /// 订单状态
    let orderState = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 16)
    }
    
    /// 状态线
    let stateLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    /// 定位导航图标
    let image = UIImageView().then{
        $0.image = UIImage.init(named: "address_icon")
    }
    
    /// 地址
    let address = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    
    /// 收货人名称
    let name = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 12)
    }
    
    /// 收货人电话
    let phone = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 12)
    }
    
    /// 地址信息下的线
    let addressLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    /// 商家图片
    let mchPic = UIImageView().then{
        $0.backgroundColor = .random
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    /// 商家名称
    let mchName = UILabel().then{
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .black
    }
    /// 商品线
    let mchLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    

    override func configUI() {
        
        addSubview(view)
        view.addSubview(orderState)
        view.addSubview(stateLine)
        view.addSubview(image)
        view.addSubview(address)
        view.addSubview(name)
        view.addSubview(phone)
        view.addSubview(addressLine)
        view.addSubview(mchPic)
        view.addSubview(mchName)
        view.addSubview(mchLine)
        
        view.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.centerX.width.equalToSuperview()
        }
        
        //MARK:订单状态
        orderState.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        
        //MARK:状态线
        stateLine.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.top.equalTo(orderState.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        //MARK:地址图片
        image.snp.makeConstraints { (make) in
            make.top.equalTo(stateLine).offset(23)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(13)
        }
        //MARK:地址
        address.snp.makeConstraints { (make) in
            make.left.equalTo(image.snp.right).offset(10)
            make.top.equalTo(stateLine).offset(10)
        }
        //MARK:收货人名字
        name.snp.makeConstraints { (make) in
            make.left.equalTo(address)
            make.top.equalTo(address.snp.bottom).offset(7)
        }
        //MARK:手机号
        phone.snp.makeConstraints { (make) in
            make.left.equalTo(name.snp.right).offset(10)
            make.bottom.equalTo(name)
        }
        //MARK:地址线
        addressLine.snp.makeConstraints { (make) in
            make.left.width.equalToSuperview()
            make.top.equalTo(image.snp.bottom).offset(23)
            make.height.equalTo(1)
        }
        //MARK:商家图片
        mchPic.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(addressLine.snp.bottom).offset(11)
            make.size.equalTo(20)
        }
        //MARK:商家名称
        mchName.snp.makeConstraints { (make) in
            make.centerY.equalTo(mchPic)
            make.left.equalTo(mchPic.snp.right).offset(7)
        }
        //MARK:商家分割线
        mchLine.snp.makeConstraints { (make) in
            make.top.equalTo(mchPic.snp.bottom).offset(11)
            make.height.equalTo(1)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    var data: order_detail_model?{
        didSet{
            guard let data = data else { return }
            switch data.status_code {
            case 0:
                orderState.text = "待付款"
                orderState.textColor = .hex(hexString: "#F51616")
            case 1:
                orderState.text = "待发货"
                orderState.textColor = .hex(hexString: "#FF7B1B")
            case 2:
                orderState.text = "待收货"
                orderState.textColor = .hex(hexString: "#4B93FE")
            case 3:
                orderState.text = "订单已完成"
                orderState.textColor = .hex(hexString: "#0EC262")
            case 5:
                orderState.text = "已取消"
                orderState.textColor = .hex(hexString: "#999999")
            default:
                break
            }
            
            address.text = data.address
            name.text = data.name
            phone.text = data.mobile
            mchPic.load(data.mch.logo)
            mchName.text = data.mch.name
            
        }
    }

}
