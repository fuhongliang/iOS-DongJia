//
//  UOrderInfoCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/13.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit

class UOrderInfoCell: UBaseTableViewCell {

    
    let orderInfo = UILabel().then{
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 16)
        $0.text = "订单信息"
    }
    
    let orderInfoLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    let orderNumberLabel = UILabel().then{
        $0.text = "订单编号"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 13)
    }
    /// 订单编号
    let orderNumber = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 复制
    let copy = QMUIGhostButton().then{
        $0.ghostColor = .hex(hexString: "#E6E6E6")
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.setTitle("复制", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 11)
    }
    let orderTimeLabel = UILabel().then{
        $0.text = "订单时间"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 订单时间
    let orderTime = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 14)
    }
    
    override func configUI() {
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(orderInfo)
        contentView.addSubview(orderInfoLine)
        contentView.addSubview(orderNumberLabel)
        contentView.addSubview(orderNumber)
        contentView.addSubview(copy)
        contentView.addSubview(orderTimeLabel)
        contentView.addSubview(orderTime)
        
        //MARK:支付信息
        orderInfo.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
        }
        
        //MARK:线
        orderInfoLine.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.top.equalTo(orderInfo.snp.bottom).offset(15)
            make.height.equalTo(1)
        }
        
        //MARK: 订单编号
        orderNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(orderInfoLine.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        //MARK:复制
        copy.snp.makeConstraints { (make) in
            make.top.equalTo(orderInfoLine.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 40, height: 19))
        }
        
        orderNumber.snp.makeConstraints { (make) in
            make.top.equalTo(orderInfoLine.snp.bottom).offset(15)
            make.right.equalTo(copy.snp.left).offset(-13)
        }
        
        //MARK:订单时间
        orderTimeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(orderNumberLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15)
        }
        
        orderTime.snp.makeConstraints { (make) in
            make.top.equalTo(orderNumberLabel.snp.bottom).offset(15)
            make.right.equalTo(copy).offset(-13)
            make.bottom.equalToSuperview().offset(-15)
        }

    }

    var data: order_detail_model?{
        didSet{
            guard let data = data else { return }
            orderNumber.text = data.order_no
            orderTime.text = data.addtime
            
        }
    }

}
