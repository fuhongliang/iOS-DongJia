//
//  UMyCollectionCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

var collectionCellWidth = ((screenWidth-40)/2)

class UMyCollectionCell: UBaseCollectionViewCell {
    
    var picture = UIImageView().then{
        $0.image = UIImage.init(named: "default_icon")
    }
    var goodsNameLabel = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var rmbLabel = UILabel().then{
        $0.text = "¥199.99"
        $0.textColor = UIColor.hex(hexString: "#F61616")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var originalPriceLabel = UILabel().then{
        $0.text = "0.00"
        $0.textColor = UIColor.hex(hexString: "#999999")
        $0.font = UIFont.systemFont(ofSize: 9)
    }
    
    let buyPeopleOfNum = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .right
    }
    
    override func configUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        contentView.layer.masksToBounds = true
        contentView.addSubview(picture)
        contentView.addSubview(goodsNameLabel)
        contentView.addSubview(rmbLabel)
        contentView.addSubview(originalPriceLabel)
        contentView.addSubview(buyPeopleOfNum)
        //MARK:商品图片
        picture.snp.makeConstraints { (make) in
            make.width.equalTo(collectionCellWidth)
            make.height.equalTo(collectionCellWidth-10)
            make.top.left.equalToSuperview()
        }
        //MARK:商品名称
        goodsNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(picture).offset(5)
            make.right.equalTo(picture).offset(-30)
            make.top.equalTo(picture.snp.bottom).offset(5)
        }
        //MARK:当前价格
        rmbLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(goodsNameLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalTo(goodsNameLabel)
        }
        //MARK:原价
        originalPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(rmbLabel.snp.right).offset(8)
            make.bottom.equalTo(rmbLabel)
        }
        //MARK:购买人数
        buyPeopleOfNum.snp.makeConstraints { (make) in
            make.left.equalTo(originalPriceLabel.snp.right)
            make.right.equalTo(picture).offset(-5)
            make.bottom.equalTo(rmbLabel)
        }
        
        let view = UIView()
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(picture.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
    }
    
    var data:[String:String]? {
        didSet {
            guard let data = data else { return }
            picture.load(data["pic_url"])
            rmbLabel.text = "¥\(data["price"] ?? "-")"
            originalPriceLabel.setUnderLine(text: "¥\(data["origin_price"] ?? "-")")
            goodsNameLabel.text = data["name"]
            buyPeopleOfNum.text = "\(data["buy_num"] ?? "")人已买"
        }
    }
}
