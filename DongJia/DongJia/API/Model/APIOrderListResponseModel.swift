//
//  APIOrderListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIOrderListResponseModel: Codable {
    var code: Int
    var msg: String
    var data: order_list_model
}
struct order_list_model: Codable {
    var row_count: String
    var page_count: Int
    var list: [order_list]
    var pay_type_list: [pay_type_list]
}
struct order_list: Codable {
    var status: String
    var status_code: Int
    var order_id: Int
    var order_no: String
    var addtime: String
    var goods_list: [goods_list_model]
    var total_price: String
    var is_pay: Int
    var is_send: Int
    var is_confirm: Int
    var is_comment: Int
    var apply_delete: Int
    var is_offline: Int
    var qrcode: String?
    var offline_qrcode: String?
    var express: String
    var mch: mch_model
    var pay_type: Int
}
struct goods_list_model: Codable {
    var goods_id: Int
    var goods_pic: String
    var goods_name: String
    var num: Int
    var price: String
    var attr_list: [order_goods_attr_list]
}
struct order_goods_attr_list: Codable {
    var attr_id: String
    var attr_group_name: String
    var attr_name: String
    var no: String
}
struct mch_model: Codable {
    var logo: String
    var name: String
    var id: Int
}
struct pay_type_list: Codable {
    var name: String
    var payment: Int
    var icon: String
}
