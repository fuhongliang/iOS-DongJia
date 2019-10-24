//
//  APIOrderSubmitViewResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/24.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIOrderSubmitViewResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: submit_view_model?
}
struct submit_view_model: Codable{
    var total_price: Int
    var cart_id_list: [Int]
    var list: [submit_view_list_model]
    var address: submit_view_address_model
    var express_price: Int
    var integral: submit_view_integral_model
    var goods_card_list: [String]
    var mch_list: [submit_view_mch_list_model]
    var offer_rule: submit_view_offer_rule_model
    var coupon_list: [String]
    var shop_list: [submit_view_shop_list_model]
    var is_shop: submit_view_is_shop_model
    var level: String?
    var send_type: Int
    var form: submit_view_form_model
    var is_payment: submit_view_is_payment_model
    var pay_type_list: [submit_view_pay_type_list_model]
    var is_area: Int
}
struct submit_view_list_model: Codable {
    var cart_id: Int
    var goods_id: Int
    var goods_name: String
    var goods_pic: String
    var num: Int
    var price: String
    var single_price: Int
    var attr_list: shop_cart_attr_list
    var give: Int
    var freight: Int
    var integral: String
    var weight: Int
    var full_cut: String
    var cat_id: Int
    var mch_id: Int
}
struct submit_view_address_model: Codable {
    var id: String
    var name: String
    var mobile: String
    var province_id: String
    var province: String
    var city_id: String
    var city: String
    var district_id: String
    var district: String
    var detail: String
    var is_default: String
}
struct submit_view_integral_model: Codable {
    var forehead: Int
    var forehead_integral: Int
    var integration: String
}
struct submit_view_mch_list_model: Codable {
    var total_price: Int
    var cart_id_list: [Int]
    var list: [submit_view_list_model]
    var address: submit_view_address_model
    var express_price: Int
    var integral: submit_view_mch_list_integral_model
    var goods_card_list: [String]
    var id: Int
    var name: String
    var mch_logo: String
}
struct submit_view_mch_list_integral_model: Codable {
    var forehead: Int
    var forehead_integral: Int
}
struct submit_view_offer_rule_model: Codable {
    var is_allowed: Int
    var total_price: Int
    var msg: String
}
struct submit_view_shop_list_model: Codable {
    var address: String
    var mobile: String
    var id: String
    var name: String
    var longitude: String
    var latitude: String
    var distance: Int
}
struct submit_view_is_shop_model: Codable {
    var id: String
    var store_id: String
    var name: String
    var mobile: String
    var address: String
    var is_delete: String
    var addtime: String
    var longitude: String
    var latitude: String
    var score: String
    var cover_url: String
    var pic_url: String
    var shop_time: String
    var content: String
    var is_default: String
}
struct submit_view_form_model: Codable {
    var is_form: Int
    var list: [String]
}
struct submit_view_is_payment_model: Codable {
    var wechat: String
    var balance: String
}
struct submit_view_pay_type_list_model: Codable {
    var name: String
    var payment: Int
    var icon: String
}
