//
//  UPayInfoCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/13.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UPayInfoCell: UBaseTableViewCell {

    let payInfo = UILabel().then{
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        $0.text = "支付信息"
    }
    
    let payInfoLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    /// 支付方式 文本
    let payTypeLabel = UILabel().then{
        $0.text = "支付方式"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 13)
    }
    /// 支付方式
    let payType = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 订单金额 文本
    let orderPriceLabel = UILabel().then{
        $0.text = "订单金额"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 订单金额
    let orderPrice = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 运费 文本
    let freightLabel = UILabel().then{
        $0.text = "运费"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 运费
    let freight = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 实际支付 文本
    let lastPayLabel = UILabel().then{
        $0.text = "实际支付"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 实际支付
    let lastPay = UILabel().then{
        $0.textColor = .hex(hexString: "#F51616")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 备注 文本
    let messageLabel = UILabel().then{
        $0.text = "备注"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 备注
    let message = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 14)
    }
    
    override func configUI() {
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(payInfo)
        contentView.addSubview(payInfoLine)
        contentView.addSubview(payTypeLabel)
        contentView.addSubview(payType)
        contentView.addSubview(orderPriceLabel)
        contentView.addSubview(orderPrice)
        contentView.addSubview(freightLabel)
        contentView.addSubview(freight)
        contentView.addSubview(lastPayLabel)
        contentView.addSubview(lastPay)
        contentView.addSubview(messageLabel)
        contentView.addSubview(message)
        
        //MARK:支付信息
        payInfo.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        
        //MARK:线
        payInfoLine.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.top.equalTo(payInfo.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        //MARK:支付方式
        payTypeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(payInfoLine.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        payType.snp.makeConstraints { (make) in
            make.top.equalTo(payInfoLine.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:订单金额
        orderPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(payTypeLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        orderPrice.snp.makeConstraints { (make) in
            make.top.equalTo(payTypeLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:运费
        freightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(orderPriceLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        freight.snp.makeConstraints { (make) in
            make.top.equalTo(orderPriceLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:实际支付
        lastPayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(freightLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        lastPay.snp.makeConstraints { (make) in
            make.top.equalTo(freightLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:备注
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lastPayLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        message.snp.makeConstraints { (make) in
            make.top.equalTo(lastPayLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    var data: order_detail_model?{
        didSet{
            guard let data = data else { return }
            payType.text = data.pay_type == 0 ? "余额支付" : "微信支付"
            orderPrice.text = "¥\(data.total_price)"
            freight.text = "¥\(data.express_price)"
            lastPay.text = "¥\(data.pay_price)"
            message.text = data.words ?? "无"
            
        }
    }
}
