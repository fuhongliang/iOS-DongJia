//
//  APIStoreService.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/11.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIStoreServiceProtocol {
    /// 获取店铺信息
    func getStoreInfo(mchId: String, page: String, _ success: @escaping(((APIStoreInfoResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    /// 获取店铺的精品案例
    func getStoreClassicCase(mchId: String, _ success: @escaping(((APIStoreClassicCaseResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIStoreService: APIStoreServiceProtocol {
    
    //MARK:获取店铺信息
    func getStoreInfo(mchId: String, page: String, _ success: @escaping (((APIStoreInfoResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "tab": 2,
            "sort": 1,
            "access_token": APIUser.shared.user!.access_token,
            "mch_id":mchId,
            "page": page
        ]
        APIService.shared.request(.storeInfo(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIStoreInfoResponseModel.self, from: data)
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
    //MARK:获取店铺精品案例
    func getStoreClassicCase(mchId: String, _ success: @escaping (((APIStoreClassicCaseResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "mch_id":mchId,
            "access_token": APIUser.shared.user!.access_token
        ]
        APIService.shared.request(.storeClassicCase(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIStoreClassicCaseResponseModel.self, from: data)
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
