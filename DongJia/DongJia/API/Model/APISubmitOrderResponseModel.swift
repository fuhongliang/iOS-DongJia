//
//  APISubmitOrderResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APISubmitOrderResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: submit_order_model?
}
struct submit_order_model: Codable {
    var order_id_list: [Int]? = nil
    var order_id: Int? = nil
}
