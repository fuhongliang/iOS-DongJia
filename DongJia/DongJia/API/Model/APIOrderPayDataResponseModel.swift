//
//  APIOrderPayDataResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APIOrderPayDataResponseModel: Codable {
    var code: Int
    var msg: String
    var data: pay_data
    var res: pay_res
    var body: String
}
struct pay_data: Codable {
    var appid: String
    var partnerid: String
    var prepayid: String
    var package: String
    var noncestr: String
    var timestamp: UInt32
    var sign: String
}
struct pay_res: Codable {
    var return_code: String
    var return_msg: String
    var appid: String
    var mch_id: String
    var nonce_str: String
    var sign: String
    var result_code: String
    var prepay_id: String
    var trade_type: String
}
