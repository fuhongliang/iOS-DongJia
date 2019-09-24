//
//  APIMainService.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/23.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIMainServiceProtocol {
    func getMainData(district: String, _ success: @escaping(((APIMainDataResponsModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIMainService: APIMainServiceProtocol {
    
    func getMainData(district: String, _ success: @escaping (((APIMainDataResponsModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "app_key": "ios",
            "district": district
        ]
        
        APIService.shared.request(.getMainData(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIMainDataResponsModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print(APIErrorModel)
        }
        
    }
    
}
