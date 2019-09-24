//
//  ULimitedTimeCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

//MARK:限时抢购的cell
class ULimitedTimeCell: UBaseCollectionViewCell {
    
    var picture = UIImageView().then{
        $0.layer.cornerRadius = 2
        $0.layer.masksToBounds = true
        $0.image = UIImage.init(named: "todo_img")
    }
    var timerBg = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#F8F3E6")
    }
    var timerLabel = UILabel().then{
        $0.text = "距结束24:00:00"
        $0.textColor = UIColor.hex(hexString: "#F61616")
        $0.font = UIFont.systemFont(ofSize: 9)
    }
    var goodsNameLabel = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var discountPriceLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.hex(hexString: "#F61616")
        $0.text = "¥"
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
        picture.addSubview(timerBg)
        timerBg.addSubview(timerLabel)
        contentView.addSubview(goodsNameLabel)
        contentView.addSubview(discountPriceLabel)
        contentView.addSubview(rmbLabel)
        contentView.addSubview(originalPriceLabel)
        
        picture.snp.makeConstraints { (make) in
            make.size.equalTo(120)
            make.top.left.equalToSuperview()
        }
        timerBg.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.left.right.bottom.equalToSuperview()
        }
        
        timerLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        goodsNameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(picture)
            make.top.equalTo(picture.snp.bottom).offset(7.5)
        }
        discountPriceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(goodsNameLabel)
            make.top.equalTo(goodsNameLabel.snp.bottom).offset(7.5)
//            make.bottom.equalToSuperview()
        }
        rmbLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(discountPriceLabel)
            make.left.equalTo(discountPriceLabel.snp.right)
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
    
    var data: miaosha_goods_list? {
        didSet {
            guard let data = data else { return }
            goodsNameLabel.text = data.name
            originalPriceLabel.setUnderLine(text: "¥\(data.price)")
            rmbLabel.text = data.miaosha_price
            picture.load(data.pic)
            
        }
    }
    
}
