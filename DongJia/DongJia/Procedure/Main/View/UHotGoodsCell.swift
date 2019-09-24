//
//  UHotGoodsCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/16.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

var hotCellWidth = ((screenWidth-70)/3)

class UHotGoodsCell: UBaseCollectionViewCell {
    
    var picture = UIImageView().then{
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true
    }
    var timerBg = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#F8F3E6")
    }
    var goodsNameLabel = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var rmbLabel = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#F61616")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var originalPriceLabel = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#999999")
        $0.font = UIFont.systemFont(ofSize: 9)
    }
    
    
    override func configUI() {
        
        contentView.addSubview(picture)
        contentView.addSubview(goodsNameLabel)
        contentView.addSubview(rmbLabel)
        contentView.addSubview(originalPriceLabel)

        picture.snp.makeConstraints { (make) in
//            make.size.equalTo(hotCellWidth)
            make.width.equalTo(hotCellWidth)
            make.height.equalTo(hotCellWidth*0.9)
            make.top.left.equalToSuperview()
        }

        goodsNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(picture)
            make.top.equalTo(picture.snp.bottom).offset(5)
        }
        rmbLabel.snp.makeConstraints { (make) in
            make.top.equalTo(goodsNameLabel.snp.bottom).offset(5)
            make.left.equalTo(goodsNameLabel)
        }
        originalPriceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(picture)
            make.bottom.equalTo(rmbLabel)
        }
        
        let view = UIView()
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(rmbLabel.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
    }
    
    var data: recommend_goods? {
        didSet {
            guard let data = data else { return }
            
            picture.load(data.cover_pic)
            goodsNameLabel.text = data.name
            originalPriceLabel.setUnderLine(text: "¥\(data.original_price)")
            rmbLabel.text = "¥\(data.price)"
            
        }
    }
}
