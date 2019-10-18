//
//  UOrderGoodsInfoCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UOrderGoodsInfoCell: UBaseTableViewCell {

    override func configUI() {
        /// 商品图片
        let goodsImg = UIImageView().then{
            $0.backgroundColor = .random
        }
        /// 商品名称
        let goodsName = UILabel().then{
            $0.text = "红木家具一套"
            $0.textColor = .hex(hexString: "#333333")
            $0.font = .systemFont(ofSize: 15)
            $0.numberOfLines = 2
        }
        /// 商品规格信息
        let goodsAttrInfo = UILabel().then{
            $0.text = "赠送广州市中心环境超棒的大别墅一套"
            $0.textColor = .hex(hexString: "#999999")
            $0.font = .systemFont(ofSize: 13)
        }
        /// 商品价格
        let goodsPrice = UILabel().then{
            $0.text = "¥10"
            $0.textColor = .hex(hexString: "#FD5757")
            $0.font = .systemFont(ofSize: 16)
        }
        /// 当前商品的购买数量
        let goodsBuyNumber = UILabel().then{
            $0.text = "x10"
            $0.textColor = .hex(hexString: "#999999")
            $0.font = .systemFont(ofSize: 15)
        }
        
        contentView.addSubview(goodsImg)
        contentView.addSubview(goodsName)
        contentView.addSubview(goodsAttrInfo)
        contentView.addSubview(goodsPrice)
        contentView.addSubview(goodsBuyNumber)
        
        //MARK:商品图片
        goodsImg.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.size.equalTo(77)
            make.bottom.equalToSuperview()
        }
        //MARK:商品名称
        goodsName.snp.makeConstraints { (make) in
            make.top.equalTo(goodsImg)
            make.left.equalTo(goodsImg.snp.right).offset(15)
            make.right.equalToSuperview().offset(-10)
        }
        //MARK:商品规格信息
        goodsAttrInfo.snp.makeConstraints { (make) in
            make.top.equalTo(goodsName.snp.bottom).offset(10)
            make.left.equalTo(goodsName)
            make.right.equalToSuperview().offset(-10)
        }
        //MARK:价格
        goodsPrice.snp.makeConstraints { (make) in
            make.bottom.equalTo(goodsImg)
            make.left.equalTo(goodsName)
        }
        //MARK:数量
        goodsBuyNumber.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(goodsPrice)
        }
    }

}
