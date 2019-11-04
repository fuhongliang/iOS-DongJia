//
//  APIDosCaseDetailResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/4.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIDosCaseDetailResponseModel: Codable {
    var code: Int
    var msg: String
    var data: dos_case_detail
}
struct dos_case_detail: Codable {
    var id: String
    var store_id: String
    var title: String
    var sub_title: String
    var cover_pic: String
    var content: String
    var read_count: String
    var layout: String
    var sort: String
    var agree_count: String
    var virtual_agree_count: String
    var virtual_favorite_count: String
    var addtime: String
    var is_delete: String
    var is_chosen: String
    var type: String
    var mch_id: String
    var master_id: String
    var is_favorite: Int
    var author: String
    var author_logo: String
}
