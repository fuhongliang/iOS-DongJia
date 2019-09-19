//
//  UFeaturedCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UFeaturedCell: UBaseCollectionViewCell {

    let featuredPic = UIImageView().then{
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.image = UIImage.init(named: "todo_img")
    }
    let featuredName = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.numberOfLines = 2
    }
    let buyNum = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#999999")
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    let currentPrice = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#F51616")
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    let beforePrice = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#999999")
        $0.font = UIFont.systemFont(ofSize: 10)
    }
    
    override func configUI() {
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 3
        
        contentView.addSubview(featuredPic)
        contentView.addSubview(featuredName)
        contentView.addSubview(buyNum)
        contentView.addSubview(currentPrice)
        contentView.addSubview(beforePrice)
        
        //MARK:精选商品图片
        featuredPic.snp.makeConstraints { (make) in
            make.height.top.left.equalToSuperview()
            make.width.equalTo(115)
        }
        
        //MARK:精选商品名称
        featuredName.snp.makeConstraints { (make) in
            make.left.right.equalTo(featuredPic.snp.right).inset(12)
            make.top.equalToSuperview().offset(12.5)
        }
        
        //MARK:购买人数
        buyNum.snp.makeConstraints { (make) in
            make.left.equalTo(featuredName)
            make.top.equalToSuperview().offset(56)
        }
        
        //MARK:当前的价格
        currentPrice.snp.makeConstraints { (make) in
            make.left.equalTo(featuredName)
            make.bottom.equalTo(featuredPic).offset(-12.5)
        }
        
        //MARK:原价
        beforePrice.snp.makeConstraints { (make) in
            make.left.equalTo(currentPrice.snp.right).offset(11)
            make.bottom.equalTo(currentPrice)
        }
        
    }
    
}
