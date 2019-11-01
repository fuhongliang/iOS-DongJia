//
//  APICatMchListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/1.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APICatMchListResponseModel: Codable {
    var code: Int
    var msg: String
    var data: cat_mch_model
}
struct cat_mch_model: Codable {
    var page: String
    var row_count: String
    var page_count: Int
    var list: [cat_mch_list_model]
}
struct cat_mch_list_model: Codable {
    var id: String
    var mch_color: String
    var header_bg: String
    var mch_name: String
    var logo: String
    var goods_list: [recommend_goods]
    var goods_count: String
}
