//
//  APIOrderDetailResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/13.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIOrderDetailResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: order_detail_model?
}
struct order_detail_model: Codable {
    var status_code: Int
    var mch: order_detail_mch_model
    var order_id: Int
    var is_pay: Int
    var is_send: Int
    var is_confirm: Int
    var status: String
    var express: String
    var express_no: String
    var name: String
    var mobile: String
    var address: String
    var order_no: String
    var addtime: String
    var total_price: Double
    var express_price: Double
    var goods_total_price: Double
    var coupon_sub_price: String
    var pay_price: String
    var num: Int
    var goods_list: [order_detail_goods_list_model]
    var is_offline: Int
    var content: String
    var before_update: String
    var money: String
    var shop: String?
    var discount: String?
    var user_coupon_id: String?
    var words: String?
    var pay_type: Int
}
struct order_detail_mch_model: Codable {
    var id: Int
    var name: String
    var logo: String
}
struct order_detail_goods_list_model: Codable {
    var goods_id: String
    var order_detail_id: String
    var name: String
    var attr: [order_detail_attr_model]
    var num: String
    var total_price: String
    var pic: String
    var goods_pic: String
    var is_order_refund: Int
    var order_refund_enable: Int
}
struct order_detail_attr_model: Codable {
    var attr_id: String
    var attr_group_name: String
    var attr_name: String
    var no: String
}
