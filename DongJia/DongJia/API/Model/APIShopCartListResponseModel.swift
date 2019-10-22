//
//  APIShopCartListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/22.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIShopCartListResponseModel: Codable{
    var code: Int?
    var msg: String?
    var data: shop_cart_list_model?
}
struct shop_cart_list_model: Codable{
    var row_count: String
    var page_count: Int
    /// 平台自营商品列表
    var list: [shop_cart_operated_list]
    /// 商家商品列表
    var mch_list: [shop_cart_mch_list]
}
struct shop_cart_operated_list: Codable{
    var cart_id: Int
    var goods_id: Int
    var goods_name: String
    var goods_pic: String
    var num: Int
    /// 商品规格
    var attr_list: [shop_cart_attr_list]
    var price: Double
    var unitPrice: Double
    var max_num: Int
    var disabled: Bool
}
struct shop_cart_mch_list: Codable{
    var id: Int
    var name: String
    var logo: String
    var list: [shop_cart_mch_goods_list]
}
struct shop_cart_mch_goods_list: Codable {
    var cart_id: Int
    var goods_id: Int
    var goods_name: String
    var goods_pic: String
    var num: Int
    /// 商品规格
    var attr_list: [shop_cart_attr_list]
    var price: Double
    var unitPrice: Double
    var max_num: Int
    var disabled: Bool
    var mch_id: Int
}
struct shop_cart_attr_list: Codable {
    var attr_group_name: String
    var attr_name: String
}
