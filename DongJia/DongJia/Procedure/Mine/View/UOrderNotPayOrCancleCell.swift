//
//  UOrderNotPayOrCancleCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/13.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UOrderNotPayOrCancleCell: UBaseTableViewCell {

    let payInfo = UILabel().then{
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        $0.text = "支付信息"
    }
    
    let payInfoLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
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
        contentView.addSubview(orderPriceLabel)
        contentView.addSubview(orderPrice)
        contentView.addSubview(freightLabel)
        contentView.addSubview(freight)
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
        
        //MARK:订单金额
        orderPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(payInfoLine.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        orderPrice.snp.makeConstraints { (make) in
            make.top.equalTo(payInfoLine.snp.bottom).offset(15)
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
        //MARK:备注
        messageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(freightLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        message.snp.makeConstraints { (make) in
            make.top.equalTo(freightLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    var data: order_detail_model?{
        didSet{
            guard let data = data else { return }
            orderPrice.text = "¥\(data.total_price)"
            freight.text = "¥\(data.express_price)"
            message.text = data.words ?? "无"
            
        }
    }
}
