//
//  APIMainFeaturedDataResponsModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/26.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIMainFeaturedDataResponsModel: Codable {
    var code: Int?
    var msg: String?
    var data: APIMainFeaturedDataModel?
}
struct APIMainFeaturedDataModel: Codable {
    var page: String
    var row_count: String
    var page_count: Int
    var list: [featured_list]
}
struct featured_list: Codable {
    var id: String
    var store_id: String
    /// 标题
    var name: String
    /// 现价
    var price: String
    /// 原价
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
    /// 封面图片
    var cover_pic: String
    var video_url: String
    var unit: String
    var individual_share: String
    var share_commission_first: String
    var share_commission_second: String
    var share_commission_third: String
    var weight: String
    var freight: String
    var full_cut: String
    var integral: String
    var use_attr: String
    var share_type: String
    var quick_purchase: String
    var hot_cakes: String
    var cost_price: String
    var member_discount: String
    var rebate: String
    var mch_id: String
    var goods_num: String
    var mch_sort: String
    /// 已售数量
    var show_integral: String
    var index_recommend: String
}
