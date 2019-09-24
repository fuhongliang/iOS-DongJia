//
//  APIMainDataResponsModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/23.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIMainDataResponsModel: Codable {
    var code: Int?
    var msg: String?
    var data: APIMainDataModel?
}
struct APIMainDataModel: Codable {
    var new_user: Int
    var module_list: [module_list]
    var store: store /// 平台信息
    var banner_list: [banner_list] /// 轮播图列表
    var nav_icon_list: [nav_icon_list] /// 分类图标列表
    var cat_goods_cols: Int
    var cat_list: [String]
    var block_list: [block_list]
    var coupon_list: [coupon_list]
    var topic_list: [topic_list]
    var nav_count: Int
    var notice: String
    var miaosha: miaosha
    var pintuan: pintuan
    var yuyue: [String]
    var update_list: update_list
    var act_modal_list: [String]
    var mch_list: [String]
    var news_list: [news_list] /// 热门家装列表
    var master_list: [master_list] ///
    var recommend_goods: [recommend_goods] /// 爆款热卖
    var new_mch_list: [new_mch_list] /// 超级品牌列表
}
struct module_list: Codable {
    var name: String
}
struct store: Codable {
    var store_logo: String
    var id: Int
    var name: String
    var is_coupon: Int
    var show_customer_service: Int
    var dial: Int
    var dial_pic: String
    var service: String
    var copyright: String
    var copyright_url: String
    var contact_tel: String
    var cat_style: Int
    var cut_thread: Int
    var address: String
    var is_offline: Int
    var option: option!
    var purchase_frame: Int
}
struct option: Codable {
    var service: String
    var web_service: String
    var web_service_url: String
    var wxapp: wxapp!
}
struct wxapp: Codable {
    var pic_url: String
    var appid: String
    var path: String
}

struct banner_list: Codable {
    var id: String
    var store_id: String
    var pic_url: String
    var title: String
    var page_url: String
    var sort: String
    var addtime: String
    var is_delete: String
    var type: String
    var open_type: String
}

struct nav_icon_list: Codable {
    var name: String /// 名称
    var pic_url: String /// 图标
    var url: String
    var open_type: String
}

struct block_list: Codable {
    var id: Int
    var name: String
    var data: block_list_data!
    var style: Int
}
struct block_list_data: Codable {
    var pic_list: [pic_list]!
}
struct pic_list: Codable {
    var pic_url: String
    var url: String
    var open_type: String
}

struct coupon_list: Codable {
    var id: String
    var store_id: String
    var mch_id: String
    var name: String
    var desc: String
    var pic_url: String?// 文档上标注类型为null
    var discount_type: String
//    var min_price: String// 文档上标注类型为numberString
//    var sub_price: String// 文档上标注类型为StringNumber
    var discount: String
    var expire_type: String
    var expire_day: String
    var begin_time: String
    var end_time: String
    var addtime: String
    var is_delete: String
    var total_count: String
    var is_join: String
    var sort: String
    var cat_id_list: String
    var appoint_type: String
    var is_integral: String
    var price: String
    var total_num: String
    var user_num: String
    var goods_id_list: String
    var user_type: String
    var is_receive: String
    var begintime: String
    var endtime: String
    var show_time: String
    var content: String
    var goods: [coupon_list_goods]!
    var cat: [coupon_list_cat]!
}
struct coupon_list_goods: Codable {
    var id: String
}
struct coupon_list_cat: Codable {
    var id: String
    var name: String
}
struct topic_list: Codable {
    var id: String
    var title: String
}


struct miaosha: Codable {
    var name: String
    var rest_time: Int
    var goods_list: [miaosha_goods_list]
}
struct miaosha_goods_list: Codable {
    var id: String
    var name: String
    var pic: String
    var price: String
    var start_time: String
    var miaosha_price: String
}

struct pintuan: Codable {
    var goods_list: [pintuan_goods_list]
}
struct pintuan_goods_list: Codable {
    var id: String
    var name: String
    var pic: String
    var price: String
    var sale_num: Int
}

struct update_list: Codable {
    var topic: update_list_topic
    var notice: update_list_notice
    var video: [update_list_video]
    var coupon: update_list_coupon
}
struct update_list_topic: Codable{
    var logo_2: String
    var logo_1: String
    var heated: String
    var count: String
}
struct update_list_notice: Codable {
    var name: String
    var bg_color: String
    var color: String
    var icon: String
}
struct update_list_video: Codable {
    var name: Int
    var url: String
    var pic_url: String
}
struct update_list_coupon: Codable {
    var bg: String
    var bg_1: String
}


struct news_list: Codable {
    var id: String
    var cover_pic: String
    var title: String
    var addtime: String
    var author: String
    var author_logo: String
}
struct master_list: Codable {
    var id: String
    var cover_pic: String
    var name: String
    var job: String
}
struct recommend_goods: Codable {
    var id: String
    var store_id: String
    var name: String /// 商品名称
    var price: String /// 商品现价
    var original_price: String /// 商品原价
    var detail: String
    var cat_id: String
    var status: String
    var addtime: String
    var is_delete: String
    var attr: String
    var service: String
    var sort: String
    var virtual_sales: String
    var cover_pic: String /// 商品图片
    var video_url: String? /// 文档上标注为nullString
    var unit: String
    var individual_share: String
    var share_commission_first: String
    var share_commission_second: String
    var share_commission_third: String
    var weight: String
    var freight: String
    var full_cut: String
    var integral: String? /// 文档上标注类型为nullString
    var use_attr: String
    var share_type: String
    var quick_purchase: String? /// 文档上标注类型为nullString
    var hot_cakes: String? /// 文档上标注类型为nullString
    var cost_price: String
    var member_discount: String
    var rebate: String
    var mch_id: String
    var goods_num: String
    var mch_sort: String
    var show_integral: String
}
struct new_mch_list: Codable {
    var id: String
    var mch_name: String /// 商家名称
    var mch_logo: String /// 商家logo
    var mch_desc: String? /// 文档上类型标注为strignNull
    var mch_color: String
    var header_bg: String
    var goods_list: [recommend_goods] /// 商品列表 文档上 字段\类型 一致
    var goods_count: String /// 商品总数
}
