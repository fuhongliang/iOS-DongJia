//
//  APIDistrictListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/23.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIDistrictListResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: [district_province_list]?
}
struct district_province_list: Codable {
    var id: Int
    var name: String
    var parent_id: Int
    var level: String
    var list: [district_city_list]
}
struct district_city_list: Codable {
    var id: Int
    var name: String
    var parent_id: Int
    var level: String
    var list: [district_area_list]
}
struct district_area_list: Codable {
    var id: Int
    var name: String
    var parent_id: Int
    var level: String
    var list: [String]
}
