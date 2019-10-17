//
//  APIGoodsAttrDataResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIGoodsAttrDataResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: goods_attr_data?
}
struct goods_attr_data: Codable {
    var attr_list: goods_attr_info
    var num: Int
    var price: String
    var no: String
    var pic: String
    var miaosha: String?
    
}
struct goods_attr_info: Codable {
    var attr_id: Int
    var attr_name: String
}
