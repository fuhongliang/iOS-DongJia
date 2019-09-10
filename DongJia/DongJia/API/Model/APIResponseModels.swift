//
//  APIResponseModels.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation

class APIErrorModel {

    var code: Int?

    var msg: String?

    var data: String?

    public static func getErrorModel(_code: Int?, _msg: String?, _data: String?) -> APIErrorModel {
        let model = APIErrorModel()
        model.code = _code
        model.msg = _msg
        model.data = _data
        return model
    }
}

//返回空对象
class APIObjectModel: Codable{
    
    var code: Int?
    
    var msg: String?
    
    var data: ObjectModel?
}

class ObjectModel: Codable{
    
}

//返回空数组
class APIListModel: Codable {

    var code: Int?

    var msg: String?

    var data: [String]?
}

//MARK:登录返回的Json数据
class APILoginResponseModel: Codable {

    var code: Int?

    var msg: String?

    var data: DataModel?

}

// MARK:登录成功返回Data对象
class DataModel: Codable {
    var mch_info: MchInfo?
}

// MARK:登录成功返回商户对象
class MchInfo: Codable {
    var mch_id: Int?

    var access_token: String?

    var store_id: Int?

    var is_open: Int?

    var is_lock: Int?

    var review_status: Int?

    var review_result: String?

    var review_time: Int?

    var realname: String?

    var tel: String?

    var mch_name: String?

    var service_tel: String?

    var logo: String?


}
