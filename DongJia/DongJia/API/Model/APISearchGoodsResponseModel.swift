//
//  APISearchGoodsResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/29.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APISearchGoodsResponseModel: Codable {
    var code: Int
    var msg: String
    var data: search_goods_list_model
}
struct search_goods_list_model: Codable {
    var row_count: String
    var page_count: Int
    var list: [search_goods_model]
}
struct search_goods_model: Codable {
    var id: String
    var name: String
    var sort: String
    var addtime: String
    var price: String
    var pic_url: String
    var store_id: String
    var status: String
    var is_delete: String
    var goods_type: String
    var url: String
}
