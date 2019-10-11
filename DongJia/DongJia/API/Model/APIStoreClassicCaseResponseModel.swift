//
//  APIStoreClassicCaseResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/11.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIStoreClassicCaseResponseModel: Codable{
    var code: Int?
    var msg: String?
    var data: [store_classic_case_model]?
}

struct store_classic_case_model: Codable{
    var id: Int
    var store_id: Int
    var title: String
    var sub_title: String
    var cover_pic: String
    var content: String
    var read_count: Int
    var virtual_read_count: Int
    var layout: Int
    var sort: Int
    var agree_count: Int
    var virtual_agree_count: Int
    var virtual_favorite_count: Int
    var addtime: Int
    var is_delete: Int
    var is_chosen: Int
    var type: Int
    var mch_id: Int
    var master_id: Int
}
