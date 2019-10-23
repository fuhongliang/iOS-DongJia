//
//  APIAddressListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/23.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIAddressListResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: address_list_model?
}
struct address_list_model: Codable {
    var list: [address_model]
}
struct address_model: Codable {
    var id: String
    var name: String
    var mobile: String
    var province_id: String
    var province: String
    var city_id: String
    var city: String
    var district_id: String
    var district: String
    var detail: String
    var is_default: String
    var address: String
}
