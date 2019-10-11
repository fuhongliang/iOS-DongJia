//
//  APIStoreInfoResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/11.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIStoreInfoResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: store_info_model?
}
struct store_info_model: Codable {
    var is_favorite: Int
    /// 商家信息
    var shop: store_info
    var coupon_list: [String]
    var banner_list: [String]
    var goods_list: [store_goods_list]
    var new_list: [String]
    /// 推荐商品
    var recommend_list: [store_goods_list]
}
struct store_info: Codable {
    var id: Int
    var name: String
    var mch_desc: String
    var header_color: String
    var mch_color: String
    var logo: String
    var header_bg: String
    var goods_num: String?
    var sale_num: String
}
struct store_goods_list: Codable {
    var id: String
    var store_id: String
    var name: String
    var price: String
    var original_price: String
    var detail: String
    var cat_id: String
    var status: String
    var addtime: String
    var is_delete: String
    var attr: String
    var service: String
    var sort: String
    var virtual_sales: String
    var cover_pic: String
    var video_url: String?
    var unit: String
    var individual_share: String
    var share_commission_first: String
    var share_commission_second: String
    var share_commission_third: String
    var weight: String
    var freight: String
//    var sale_num: String
    var full_cut: String
    var integral: String?
    var use_attr: String
    var share_type: String
    var quick_purchase: String?
    var hot_cakes: String?
    var cost_price: String
    var member_discount: String
    var rebate: String
    var mch_id: String
    var goods_num: String
    var mch_sort: String
    var show_integral: String
    var index_recommend: String
}
//struct store_recommend_list: Codable {
//    var id: String
//    var store_id: String
//    var name: String
//    var price: String
//    var original_price: String
//    var detail: String
//    var cat_id: String
//    var status: String
//    var addtime: String
//    var is_delete: String
//    var attr: String
//    var service: String
//    var sort: String
//    var virtual_sales: String
//    var cover_pic: String
//    var video_url: String?
//    var unit: String
//    var individual_share: String
//    var share_commission_first: String
//    var share_commission_second: String
//    var share_commission_third: String
//    var weight: String
//    var freight: String
//    var sale_num: String
//    var full_cut: String
//    var integral: String
//    var use_attr: String
//    var share_type: String
//    var quick_purchase: String?
//    var hot_cakes: String?
//    var cost_price: String
//    var member_discount: String
//    var rebate: String
//    var mch_id: String
//    var goods_num: String
//    var mch_sort: String
//    var show_integral: String
//    var index_recommend: String
//}
