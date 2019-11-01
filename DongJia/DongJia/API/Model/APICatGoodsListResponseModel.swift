//
//  APICatGoodsListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/1.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APICatGoodsListResponseModel: Codable {
    var code: Int
    var msg: String
    var data: cat_goods_model
}
struct cat_goods_model: Codable {
    var row_count: String
    var page_count: Int
    var list: [cat_goods_list_model]
    var banner_list: [String]
}
struct cat_goods_list_model: Codable {
    var id: String
    var name: String
    var price: String
    var original_price: String
    var pic_url: String
    var num: String?
    var virtual_sales: String
    var unit: String
    var show_integral: String
    var sales: String
}
