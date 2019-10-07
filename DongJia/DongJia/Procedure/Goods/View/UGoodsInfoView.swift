//
//  UGoodsInfoCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

/// 基本商品的信息(图片,名字,价格,原价)
class UGoodsInfoView: BaseView {
    var click: (() -> ())?

    var picture = UIImageView().then{
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true
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
    var btn = UIButton()
    
    override func configUI() {
        
        self.addSubview(picture)
        self.addSubview(goodsNameLabel)
        self.addSubview(rmbLabel)
        self.addSubview(originalPriceLabel)
        self.addSubview(btn)
        
        picture.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo((screenWidth-50)/3*0.9)
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
        
        //MARK:btn
        btn.backgroundColor = .clear
        btn.snp.makeConstraints { (make) in
            make.top.equalTo(picture)
            make.bottom.equalToSuperview()
            make.width.equalTo(hotCellWidth)
        }
        btn.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
        
        let view = UIView()
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(rmbLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
        
    }
    @objc func clickAction(){
        click?()
    }
    
    var data:String?{
        didSet {
            guard let data = data else { return }
            picture.image = UIImage.init(named: "default_icon")
            goodsNameLabel.text = "北欧实木大床"
            rmbLabel.text = "¥1680"
            originalPriceLabel.setUnderLine(text: "¥3300")
        }
    }

}
