//
//  APIGoodsDetailResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/9.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIGoodsDetailResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: APIGoodsDetailModel?
}
struct APIGoodsDetailModel: Codable {
    /// 优惠券标题
    var coupon_title: [String]
    /// 优惠券列表
    var coupon_list: [goods_detail_coupon_list]
    var id: Int
    /// 轮播图列表
    var pic_list: [goods_detail_pic_list]
    /// 规格列表(需手动转成Json)
    var attr: String
    var name: String
    var cat_id: Int
    var price: String
    var detail: String
    var sales_volume: Int
    /// 商品属性列表
    var attr_group_list: [goods_detail_attr_group_list]
    /// 商品库存
    var num: Int
    var is_favorite: Int
    /// 服务标签🏷
    var service_list: [String]
    /// 商品原价
    var original_price: Int
    var video_url: String?
    /// 单位
    var unit: String
    /// 选择的属性
    var use_attr: Int
    /// 商家信息
    var mch: goods_detail_mch
    var show_integral: Int
    
}
struct goods_detail_coupon_list: Codable {
    var id: String
    var store_id: String
    var mch_id: String
    var name: String
    var desc: String
    var pic_url: String?
    var discount_type: String
    var min_price: String
    var sub_price: String
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
    var integral: String
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
    var goods: [String]
    var cat: [String]
}
struct goods_detail_pic_list: Codable {
    var pic_url: String
}
struct goods_detail_attr_group_list: Codable {
    var attr_group_id: Int
    var attr_group_name: String
    var attr_list: [goods_detail_attr_list]
}
struct goods_detail_attr_list: Codable {
    var attr_id: Int
    var attr_name: String
}
struct goods_detail_mch: Codable {
    /// 店铺ID
    var id: Int
    /// 店铺名字
    var name: String
    /// 店铺介绍
    var mch_desc: String
    /// 头部颜色
    var header_color: String
    /// 店铺颜色
    var mch_color: String
    /// 店铺logo
    var logo: String
    /// 头部背景图
    var header_bg: String
    /// 商品总数
    var goods_num: String
//    var sale_num: String
}
