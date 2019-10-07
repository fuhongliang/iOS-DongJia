//
//  UGoodsStoreInfoCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UGoodsStoreInfoCell: UBaseTableViewCell {

    var goods1Action:(() -> ())?
    var goods2Action:(() -> ())?
    var goods3Action:(() -> ())?
    
    /// 店铺信息的bg
    let storeInfoBg = UIView().then{
        $0.backgroundColor = .white
    }
    /// 店铺头像
    let storeIcon = UIImageView().then{
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
    }
    /// 店铺名字
    let storeName = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 综合体验
    let feel = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.text = "综合体验"
        $0.font = .systemFont(ofSize: 9)
    }
    /// 进店按钮
    let enterShop = UIButton().then{
        $0.setTitle("进店", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .theme
        $0.titleLabel?.font = .systemFont(ofSize: 12)
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    /// 分割线
    let line = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    /// 爆款推荐
    let hotLabel = UILabel().then{
        $0.text = "爆款推荐"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 15)
    }
    /// 商品1
    let goods1 = UGoodsInfoView().then{
        $0.isUserInteractionEnabled = true
    }
    /// 商品2
    let goods2 = UGoodsInfoView().then{
        $0.isUserInteractionEnabled = true
    }
    /// 商品3
    let goods3 = UGoodsInfoView().then{
        $0.isUserInteractionEnabled = true
    }
    
    override func configUI() {
        
        contentView.addSubview(storeInfoBg)
        storeInfoBg.addSubview(storeIcon)
        storeInfoBg.addSubview(storeName)
        storeInfoBg.addSubview(feel)
        storeInfoBg.addSubview(enterShop)
        storeInfoBg.addSubview(line)
        contentView.addSubview(hotLabel)
        contentView.addSubview(goods1)
        contentView.addSubview(goods2)
        contentView.addSubview(goods3)
        
        //MARK:店铺信息背景
        storeInfoBg.snp.makeConstraints { (make) in
            make.width.left.top.equalToSuperview()
            make.height.equalTo(64)
        }
        //MARK:店铺头像
        storeIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(41)
            make.left.equalToSuperview().offset(15)
        }
        //MARK:店铺名字
        storeName.snp.makeConstraints { (make) in
            make.left.equalTo(storeIcon.snp.right).offset(8.5)
            make.top.equalTo(storeIcon).offset(2)
        }
        //MARK:综合体验
        feel.snp.makeConstraints { (make) in
            make.left.equalTo(storeName)
            make.bottom.equalTo(storeIcon).offset(-2)
        }
        //MARK:进店按钮
        enterShop.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(45)
            make.height.equalTo(24)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:分割线
        line.snp.makeConstraints { (make) in
            make.width.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        //MARK:爆款推荐
        hotLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(line.snp.bottom).offset(19)
        }
        //MARK:商品1
        goods1.snp.makeConstraints { (make) in
            make.top.equalTo(hotLabel.snp.bottom).offset(10.5)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo((screenWidth-50)/3)//.dividedBy(3)
            make.bottom.equalToSuperview()
        }
        //MARK:商品2
        goods2.snp.makeConstraints { (make) in
            make.top.equalTo(hotLabel.snp.bottom).offset(10.5)
            make.width.equalTo((screenWidth-50)/3)//.dividedBy(3)
            make.centerX.bottom.equalToSuperview()
        }
        //MARK:商品3
        goods3.snp.makeConstraints { (make) in
            make.top.equalTo(hotLabel.snp.bottom).offset(10.5)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo((screenWidth-50)/3)//.dividedBy(3)
            make.bottom.equalToSuperview()
        }
        
        goods1.click = {
            showHUDInView(text: "商品1", inView: topVC!.view, isClick: true)
        }
        goods2.click = { showHUDInView(text: "商品2", inView: topVC!.view, isClick: true) }
        goods3.click = { showHUDInView(text: "商品3", inView: topVC!.view, isClick: true) }
    }
    
    var data: String? {
        didSet {
            guard let data = data else { return }
            storeIcon.image = UIImage.init(named: "default_icon")
            storeName.text = "网易严选"
            goods1.data = "1"
            goods2.data = "2"
            goods3.data = "3"
        }
    }
    
}
