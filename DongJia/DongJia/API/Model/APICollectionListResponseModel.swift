//
//  APICollectionListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/1.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APICollectionListResonseModel: Codable {
    var code: Int
//    var msg: String
    var data: collection_data_model
}
struct collection_data_model: Codable {
    var row_count: String
    var page_count: Int
    var list: [collection_list_model]
}
struct collection_list_model: Codable {
    var goods_id: Int
    var name: String
    var price: String
    var goods_pic: String
}
