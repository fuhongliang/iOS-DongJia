//
//  APIUserServices.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation
import UIKit

protocol APIUserServicesProtocol {
    //登录接口
    func login(wxCode: String, _ success: @escaping(((APILoginResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))

    //退出登录协议
    func logout(userId: String, _ success: @escaping((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))

//    //上传图片专用
//    func uploadPic(ext:String,type:String,size:Int,image:String,_ success: @escaping(((UploadFileResponeModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))

}

class APIUserServices: APIUserServicesProtocol {
    func login(wxCode: String, _ success: @escaping (((APILoginResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id":4,
            "_uniacid":-1,
            "_acid":-1,
            "code":wxCode
        ]
        APIService.shared.request(.wxLogin(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APILoginResponseModel.self, from: data)
                if let token = model.data?.access_token {
                    saveToken(token: token)
                    APIUser.shared.user = model.data
                    APIUser.shared.saveUserToCache()
                    print("登录信息保存成功 token--\(token)")
                }
                success(model)
            } catch {
                print("解析失败--\(error)")
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print("登录请求错误:\(APIErrorModel)")
        }
    }
    //退出登录实现
    func logout(userId: String, _ success: @escaping ((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {

    }


}
