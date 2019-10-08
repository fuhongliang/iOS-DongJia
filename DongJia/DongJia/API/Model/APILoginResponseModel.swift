//
//  APILoginResponseModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/25.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class APILoginResponseModel: Codable {
    var code: Int?
    var msg: String?
    var data: APILoginDataModel?
}
struct APILoginDataModel:Codable {
    var access_token: String
    var nickname: String
    var avatar_url: String
    var is_distributor: Int
    var parent: String
    var id: Int
    var is_clerk: Int?
    var integral: Int?
    var money: String?
    var res: ResInfo
}
struct ResInfo: Codable {
    /// 接口调用凭证(暂时不用)
    var access_token: String
    /// access_token 接口调用凭证超时时间，单位（秒）
    var expires_in: Int
    /// 用户刷新 access_token
    var refresh_token: String
    /// 授权用户唯一标识
    var openid: String
    ///请求微信的内容(例如:snsapi_userinfo -> 获取用户信息)
    var scope: String
    /// 当且仅当该移动应用已获得该用户的 userinfo 授权时，才会出现该字段
    var unionid: String
}
