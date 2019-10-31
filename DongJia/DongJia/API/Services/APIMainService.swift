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
    
    func getMainFeaturedData(page: Int, _ success: @escaping(((APIMainFeaturedDataResponsModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func getSupportCityList(_ success: @escaping(((APISupportCityListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func searchGoodsList(keyWord: String, page: Int, _ success: @escaping(((APISearchGoodsResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func catList(_ success: @escaping(((APICatListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIMainService: APIMainServiceProtocol {
    /// 获取分类列表
    func catList(_ success: @escaping (((APICatListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param: [String: Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "cid":0
        ]
        APIService.shared.request(.catList(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APICatListResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print(APIErrorModel)
        }
    }
    
    /// 获取搜索商品的接口
    func searchGoodsList(keyWord: String, page: Int, _ success: @escaping (((APISearchGoodsResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "page": page,
            "keyword": keyWord
        ]
        APIService.shared.request(.searchGoods(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APISearchGoodsResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print(APIErrorModel)
        }
    }
    
    /// 获取当前支持的城市列表
    func getSupportCityList(_ success: @escaping (((APISupportCityListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
        ]
        
        APIService.shared.request(.supportCiytList(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APISupportCityListResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print(APIErrorModel)
        }
    }
    
    /// 获取首页数据
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
    
    /// 获取首页精选的数据
    func getMainFeaturedData(page: Int, _ success: @escaping (((APIMainFeaturedDataResponsModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "page": page
        ]
        APIService.sharedBackground.request(.getMainFeaturedData(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIMainFeaturedDataResponsModel.self, from: data)
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
