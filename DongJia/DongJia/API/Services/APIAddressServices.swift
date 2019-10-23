//
//  APIAddressServices.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/23.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIAddressServicesProtocol {
    
    func getMyAddressList(_ success: @escaping(((APIAddressListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func getDistrictList(_ success: @escaping(((APIDistrictListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func addOrEditAddress(address_id: String, name: String, mobile: String, province_id: Int, city_id: Int, district_id: Int, detail: String, is_default: Int, _ success: @escaping(((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIAddressServices: APIAddressServicesProtocol {
    /// 新增/更新地址
    /// - Parameters:
    ///     - address_id: 编辑地址的id
    ///     - name: 姓名
    ///     - mobile: 手机号
    ///     - province_id: 省id
    ///     - city_id: 城市id
    ///     - district_id: 地区id
    ///     - detail: 详细地址
    func addOrEditAddress(address_id: String = "", name: String, mobile: String, province_id: Int, city_id: Int, district_id: Int, detail: String, is_default: Int, _ success: @escaping (((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user!.access_token,
            "address_id":address_id,
            "name":name,
            "mobile":mobile,
            "province_id":province_id,
            "city_id":city_id,
            "district_id":district_id,
            "detail":detail,
            "is_default":is_default
        ]
        APIService.shared.request(.addOrEditAddress(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIObjectModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                print(errorModel.msg!)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            
        }
    }
    /// 获取地区列表
    func getDistrictList(_ success: @escaping (((APIDistrictListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user!.access_token
        ]
        APIService.shared.request(.districtList(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIDistrictListResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                print(errorModel.msg!)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            
        }
    }
    /// 获取我的地址列表
    func getMyAddressList(_ success: @escaping (((APIAddressListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user!.access_token
        ]
        APIService.shared.request(.addressList(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIAddressListResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                print(errorModel.msg!)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            
        }
    }
    
}
