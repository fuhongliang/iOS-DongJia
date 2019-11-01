//
//  APIDosListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/1.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIDosListResponseModel: Codable {
    var code: Int
    var msg: String
    var data: dos_list_model
}
struct dos_list_model: Codable {
    var list: [dos_model]
}
struct dos_model: Codable {
    var id: String
    var store_id: String
    var title: String
    var sub_title: String
    var cover_pic: String
    var layout: String
    var sort: String
    var agree_count: String
    var virtual_agree_count: String
    var virtual_favorite_count: String
    var addtime: String
    var is_delete: String
    var type: String
    var mch_id: String
    var master_id: String
    var author: String
    var author_logo: String
    var read_count: String
    var goods_count: String? = ""
}
