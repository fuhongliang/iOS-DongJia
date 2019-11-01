//
//  APIDosServices.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/1.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation
protocol APIDosServicesProtocol {
    
    func getDosList(page: Int, _ success: @escaping(((APIDosListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
}
class APIDosServices: APIDosServicesProtocol {
    func getDosList(page: Int, _ success: @escaping (((APIDosListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "page": page,
            "limit": 6
//            "access_token": APIUser.shared.user?.access_token ?? ""
        ]
        APIService.shared.request(.dosCase(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIDosListResponseModel.self, from: data)
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
