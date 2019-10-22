//
//  APIMineResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIMineResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: mine_model?
}
struct mine_model: Codable {
    /// 订单数量
    var order_count: mine_order_count
    var show_customer_service: Int
    var contact_tel: String
    var share_setting: mine_share_setting
    var user_info: mine_user_info
    var next_level: mine_next_level
    var menu_list: [mine_menu_list]
    var user_center_bg: String
    var orders: mine_orders
    /// 菜单列表
    var menus: [mine_menus]
    var copyright: mine_copyright
    var wallet: mine_wallet
    var style: mine_style
    var setting: mine_setting
}
struct mine_order_count: Codable {
    var all: String
    var status_0: String
    var status_1: String
    var status_2: String
    var status_3: String
}
struct mine_share_setting: Codable {
    var id: String
    var first: String
    var second: String
    var third: String
    var store_id: String
    var level: String
    var condition: String
    var share_condition: String
    var content: String?
    var pay_type: String
    var min_money: String
    var agree: String?
    var first_name: String?
    var second_name: String?
    var third_name: String?
    var pic_url_1: String?
    var pic_url_2: String?
    var price_type: String
    var bank: String?
    var remaining_sum: String
    var rebate: String
    var is_rebate: String
    var work_type: [String]
}
struct mine_user_info: Codable {
    var nickname: String
    var binding: String?
    var avatar_url: String?
    var is_distributor: Int
    var parent: String
    var id: Int
    var is_clerk: Int
    var level: Int
    var level_name: String
    var integral: Int
    var money: String
    var is_share: Bool
}
struct mine_next_level: Codable {
    var id: String
    var store_id: String
    var level: String
    var name: String
    var money: String
    var discount: String
    var status: String
    var is_delete: String
    var addtime: String
    var image: String
    var price: String
    var detail: String
    var buy_prompt: String
}
struct mine_menu_list: Codable {
    var is_show: Int
    var name: String
    var icon: String
    var open_type: String
    var url: String
    var tel: String
}
struct mine_orders: Codable {
    var status_0: mine_orders_status
    var status_1: mine_orders_status
    var status_2: mine_orders_status
    var status_3: mine_orders_status
    var status_4: mine_orders_status
}
struct mine_orders_status: Codable {
    var text: String
    var icon: String
}
struct mine_menus: Codable {
    var id: String
    var name: String
    var icon: String
    var open_type: String
    var url: String
    var tel: String
}
struct mine_copyright: Codable {
    var text: String
    var icon: String
    var url: String
    var open_type: String
    var is_phone: Int
    var phone: String
}
struct mine_wallet: Codable {
    var integral: Int
    var re: String
    var is_wallet: String
}
struct mine_style: Codable {
    var menu: String
    var top: String
}
struct mine_setting: Codable {
    var is_order: String
}
