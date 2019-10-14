//
//  APIMineServices.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/25.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIMineServicesProtocol {
    func getMineData(_ success: @escaping(((APIMineResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}
class APIMineServices: APIMineServicesProtocol {
    
    func getMineData(_ success: @escaping (((APIMineResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user?.access_token ?? ""
        ]
        APIService.shared.request(.mineData(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIMineResponseModel.self, from: data)
                success(model)
            } catch {
                print("解析失败---\(error)")
            }
        }) { (APIErrorModel) in
            print(APIErrorModel)
        }
    }
    
}
