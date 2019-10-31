//
//  APICatListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/31.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APICatListResponseModel: Codable {
    var code: Int
    var msg: String
    var data: cat_list_model
}
struct cat_list_model: Codable {
    var cat: cat_model
    var list: [primary_list_model]
}
struct cat_model: Codable {
    var name: String
}
struct primary_list_model: Codable {
    var id: String
    var store_id: String
    var parent_id: String
    var name: String
    var pic_url: String
    var big_pic_url: String
    var advert_pic: String
    var advert_url: String
    var list: [secondart_list_model]
}
struct secondart_list_model: Codable {
    var id: String
    var store_id: String
    var parent_id: String
    var name: String
    var pic_url: String
    var big_pic_url: String
}
