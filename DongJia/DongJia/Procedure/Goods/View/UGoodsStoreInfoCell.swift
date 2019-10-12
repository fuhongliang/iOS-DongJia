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
    
    var enterStoreAction:(() -> ())?
    
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
        enterShop.addTarget(self, action: #selector(enterShopAction), for: .touchUpInside)
        //MARK:分割线
        line.snp.makeConstraints { (make) in
            make.width.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        
        goods1.click = {
            let vc = UIGoodsDetailController()
            vc.goodsId = self.recommendData![0].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        goods2.click = {
            let vc = UIGoodsDetailController()
            vc.goodsId = self.recommendData![1].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        goods3.click = {
            let vc = UIGoodsDetailController()
            vc.goodsId = self.recommendData![2].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func enterShopAction(){
        if APIUser.shared.user?.access_token == nil {
            showHUDInView(text: "请先登录", inView: topVC!.view, isClick: true)
            return
        }
        enterStoreAction?()
    }
    
    func configGoods(index: Int, data: goods_recommend_list){
        switch index {
        case 0:
            contentView.addSubview(hotLabel)
            //MARK:爆款推荐
            hotLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(15)
                make.top.equalTo(line.snp.bottom).offset(19)
            }
            contentView.addSubview(goods1)
            //MARK:商品1
            goods1.snp.makeConstraints { (make) in
                make.top.equalTo(hotLabel.snp.bottom).offset(10.5)
                make.left.equalToSuperview().offset(15)
                make.width.equalTo((screenWidth-50)/3)
                make.bottom.equalToSuperview()
            }
            goods1.picUrl = data.pic_url
            goods1.goodsName = data.name
            goods1.goodsPrice = data.price
            goods1.goodsOriginPrice = data.original_price
        case 1:
            contentView.addSubview(goods2)
            //MARK:商品2
            goods2.snp.makeConstraints { (make) in
                make.top.equalTo(hotLabel.snp.bottom).offset(10.5)
                make.width.equalTo((screenWidth-50)/3)
                make.centerX.bottom.equalToSuperview()
            }
            goods2.picUrl = data.pic_url
            goods2.goodsName = data.name
            goods2.goodsPrice = data.price
            goods2.goodsOriginPrice = data.original_price
        case 2:
            contentView.addSubview(goods3)
            //MARK:商品3
            goods3.snp.makeConstraints { (make) in
                make.top.equalTo(hotLabel.snp.bottom).offset(10.5)
                make.right.equalToSuperview().offset(-15)
                make.width.equalTo((screenWidth-50)/3)
                make.bottom.equalToSuperview()
            }
            goods3.picUrl = data.pic_url
            goods3.goodsName = data.name
            goods3.goodsPrice = data.price
            goods3.goodsOriginPrice = data.original_price
        default:
            break
        }
    }
    
    /// 店铺数据
    var mchData: goods_detail_mch? {
        didSet {
            guard let data = mchData else { return }
            storeIcon.load(data.logo)
            storeName.text = data.name
            
        }
    }
    /// 精选推荐数据
    var recommendData: [goods_recommend_list]? {
        didSet{
            guard let data = recommendData else { return }
            if data.count == 0{
                storeInfoBg.snp.makeConstraints { (make) in
                    make.width.left.top.equalToSuperview()
                    make.height.equalTo(64)
                    make.bottom.equalToSuperview()
                }
            }
            for (index, data) in data.enumerated() {
                configGoods(index: index, data: data)
            }
        }
    }
    
}
