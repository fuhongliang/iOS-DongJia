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
    
    func getDosCaseDetail(id: String, _ success: @escaping(((APIDosCaseDetailResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func contactDesigner(contact: String, message: String, telephone: String, topic_id: String, _ success: @escaping(((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIDosServices: APIDosServicesProtocol {
    /// 联系设计师
    func contactDesigner(contact: String, message: String, telephone: String, topic_id: String, _ success: @escaping (((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user!.access_token,
            "contact": contact,
            "message": message,
            "telephone": telephone,
            "topic_id": topic_id
        ]
        APIService.shared.request(.contactDesigner(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIObjectModel.self, from: data)
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
    
    /// 获取家装详情
    func getDosCaseDetail(id: String, _ success: @escaping (((APIDosCaseDetailResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "id": id
        ]
        APIService.shared.request(.dosCaseDetail(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIDosCaseDetailResponseModel.self, from: data)
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
    
    /// 获取家装列表
    func getDosList(page: Int, _ success: @escaping (((APIDosListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "page": page,
            "limit": 6
        ]
        APIService.sharedBackground.request(.dosCaseList(param: param), { (data) in
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
