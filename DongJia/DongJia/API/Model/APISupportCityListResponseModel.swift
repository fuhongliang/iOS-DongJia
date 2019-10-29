//
//  APISupportCityListResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/29.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APISupportCityListResponseModel: Codable {
    var code: Int
    var msg: String
    var data: [support_city_model]
}
struct support_city_model: Codable {
    var id: String
    var parent_id: String
    var citycode: String
    var adcode: String
    var name: String
    var lng: String
    var lat: String
    var level: String
}
