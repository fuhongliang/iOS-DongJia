//
//  UOrderNotPayCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit

class UOrderListGoodsCell: UBaseTableViewCell {
    
    let view = UIView().then{
        $0.backgroundColor = .white
    }
    
    /// 商品图片
    let goodsPic = UIImageView().then{
        $0.backgroundColor = .random
    }
    /// 商品名称
    let goodsName = UILabel().then{
        $0.text = "iPhone手机📱"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 15)
    }
    /// 选择的商品属性
    let goodsAttrLabel = UILabel().then{
        $0.text = "最新 顶配"
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 13)
        $0.numberOfLines = 2
    }
    /// 该商品单价
    let goodsPrice = UILabel().then{
        $0.text = "¥10"
        $0.textColor = .hex(hexString: "#F61616")
        $0.font = .systemFont(ofSize: 16)
    }
    /// 该商品数量
    let goodsNumber = UILabel().then{
        $0.text = "x1"
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 13)
    }
    
    override func configUI() {
        
        contentView.addSubview(view)
        view.addSubview(goodsPic)
        view.addSubview(goodsName)
        view.addSubview(goodsAttrLabel)
        view.addSubview(goodsPrice)
        view.addSubview(goodsNumber)
        
        view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //MARK:商品图片
        goodsPic.snp.makeConstraints { (make) in
            make.size.equalTo(77)
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        //MARK:商品名称
        goodsName.snp.makeConstraints { (make) in
            make.left.equalTo(goodsPic.snp.right).offset(15)
            make.top.equalTo(goodsPic)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:商品规格
        goodsAttrLabel.snp.makeConstraints { (make) in
            make.top.equalTo(goodsName.snp.bottom).offset(12)
            make.left.equalTo(goodsName)
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:商品价格
        goodsPrice.snp.makeConstraints { (make) in
            make.left.equalTo(goodsName)
            make.bottom.equalTo(goodsPic)
        }
        //MARK:商品数量
        goodsNumber.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(goodsPrice)
        }
        
    }
    /// 订单详情使用
    var orderDetailData: order_detail_goods_list_model? {
        didSet{
            guard let orderDetailData = orderDetailData else { return }
            goodsPic.load(orderDetailData.goods_pic)
            goodsName.text = orderDetailData.name
            goodsPrice.text = "¥\(orderDetailData.total_price)"
            var attrLabel = ""
            for item in orderDetailData.attr {
                attrLabel += "\(item.attr_group_name):\(item.attr_name) "
            }
            goodsAttrLabel.text = attrLabel
            goodsNumber.text = "x\(orderDetailData.num)"
            
        }
    }
    
    /// 订单列表使用
    var data: goods_list_model? {
        didSet{
            guard let data = data else { return }
            goodsPic.load(data.goods_pic)
            goodsName.text = data.goods_name
            goodsPrice.text = "¥\(data.price)"
            var attrLabel = ""
            for item in data.attr_list {
                attrLabel += "\(item.attr_group_name):\(item.attr_name) "
            }
            goodsAttrLabel.text = attrLabel
            goodsNumber.text = "x\(data.num)"
            
        }
    }

}
