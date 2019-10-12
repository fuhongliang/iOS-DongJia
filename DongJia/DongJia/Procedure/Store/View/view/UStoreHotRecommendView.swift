//
//  UStoreHotRecommendView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UStoreHotRecommendView: BaseView {
    
    let view = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 45))
    let titleLabel = UILabel().then{
        $0.text = "爆款推荐"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = UIColor.black
    }

    let whiteBg = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        
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
        self.backgroundColor = .background
        self.addSubview(view)
        self.addSubview(whiteBg)
        view.addSubview(titleLabel)
        //MARK:title
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
        }
        
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.bottom)
            make.width.equalToSuperview().inset(15)
            make.bottom.centerX.equalToSuperview()
        }
        
        goods1.click = {
            let vc = UIGoodsDetailController()
            vc.goodsId = self.data![0].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        goods2.click = {
            let vc = UIGoodsDetailController()
            vc.goodsId = self.data![1].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        goods3.click = {
            let vc = UIGoodsDetailController()
            vc.goodsId = self.data![2].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func configGoods(index: Int, data: store_goods_list){
        switch index {
        case 0:
            whiteBg.addSubview(goods1)
            //MARK:商品1
            goods1.snp.makeConstraints { (make) in
                make.left.top.equalToSuperview().offset(12.5)
                make.width.equalTo((screenWidth-80)/3)
                make.bottom.equalToSuperview()
            }
            goods1.picUrl = data.cover_pic
            goods1.goodsName = data.name
            goods1.goodsPrice = data.price
            goods1.goodsOriginPrice = data.original_price
        case 1:
            whiteBg.addSubview(goods2)
            //MARK:商品2
            goods2.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(goods1)
                make.width.equalTo((screenWidth-80)/3)
                make.centerX.equalToSuperview()
            }
            goods2.picUrl = data.cover_pic
            goods2.goodsName = data.name
            goods2.goodsPrice = data.price
            goods2.goodsOriginPrice = data.original_price
        case 2:
            whiteBg.addSubview(goods3)
            //MARK:商品3
            goods3.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(goods1)
                make.right.equalToSuperview().offset(-12.5)
                make.width.equalTo((screenWidth-80)/3)
            }
            goods3.picUrl = data.cover_pic
            goods3.goodsName = data.name
            goods3.goodsPrice = data.price
            goods3.goodsOriginPrice = data.original_price
        default:
            break
        }
    }
    
    var data: [store_goods_list]?{
        didSet{
            guard let data = data else { return }
            for (index, item) in data.enumerated() {
                configGoods(index: index, data: item)
            }
            
        }
    }


}
