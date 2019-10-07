//
//  UGoodsOrdinaryBuyCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UGoodsOrdinaryBuyCell: UBaseTableViewCell {
    
    /// 当前价格
    let rmbLabel = UILabel().then{
        $0.text = "￥3398-5999"
        $0.font = .boldSystemFont(ofSize: 17)
        $0.textColor = .hex(hexString: "#F51616")
    }
    /// 购买人数
    let buyPeopleNumber = UILabel().then{
        $0.text = "33人已买"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .hex(hexString: "#999999")
    }
    /// 满额包邮
    let shipping = UILabel().then{
        $0.text = "满200元包邮"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .hex(hexString: "#999999")
    }
    
    override func configUI() {
        
        contentView.addSubview(rmbLabel)
        contentView.addSubview(buyPeopleNumber)
        contentView.addSubview(shipping)
        
        //MARK:当前的价格
        rmbLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(12.5)
        }
        //MARK:当前购买人数
        buyPeopleNumber.snp.makeConstraints { (make) in
            make.left.equalTo(rmbLabel)
            make.top.equalTo(rmbLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        //MARK:满额包邮
        shipping.snp.makeConstraints { (make) in
            make.left.equalTo(buyPeopleNumber.snp.right).offset(36)
            make.centerY.equalTo(buyPeopleNumber)
        }
        
    }

}
