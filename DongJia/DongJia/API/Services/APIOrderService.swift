//
//  APIOrderService.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/24.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIOrderServiceProtocol {
    
    func submitPreView(cart_id_list: String, mch_list: String, goods_info: String, _ success: @escaping(((APIOrderSubmitViewResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
}

class APIOrderService: APIOrderServiceProtocol {
    
    /// 下单预览接口
    func submitPreView(cart_id_list: String, mch_list: String, goods_info: String, _ success: @escaping (((APIOrderSubmitViewResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param: [String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "cart_id_list": cart_id_list,
            "mch_list": mch_list,
            "goods_info":goods_info,
            "access_token": APIUser.shared.user!.access_token
        ]
        APIService.shared.request(.submitPreView(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIOrderSubmitViewResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                print(errorModel.msg!)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print(APIErrorModel.msg ?? "----")
        }
    }
    
}
