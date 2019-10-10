//
//  APIGoodsRecommendResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation
///商品详情页中的爆款推荐
class APIGoodsRecommendResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: goods_recommend_model?
}
struct goods_recommend_model: Codable {
    var row_count: String
    var page_count: Int
    var list: [goods_recommend_list]
}
struct goods_recommend_list: Codable {
    var id: String
    var name: String
    /// 现价
    var price: String
    /// 原价
    var original_price: String
    var pic_url: String
    var num: String
    var virtual_sales: String
    var unit: String
    var sales: String
}
