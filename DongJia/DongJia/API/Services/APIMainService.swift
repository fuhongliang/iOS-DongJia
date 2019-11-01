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
    
    func catGoodsList(district: String, cat_id: String, page: Int, sort: Int, sort_type: Int, _ success: @escaping(((APICatGoodsListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func catMchList(district: String, cat_id: String, sort: Int, page: Int, _ success: @escaping(((APICatMchListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIMainService: APIMainServiceProtocol {
    /// 分类商家列表
    /// - Parameters:
    ///     - district: 地区
    ///     - cat_id: 分类id
    ///     - page: 第几页
    ///     - sort: 排序类型 1综合 2销量 3最新
    ///     - sort_type: 价格排序 0升序 1降序
    func catMchList(district: String, cat_id: String, sort: Int, page: Int, _ success: @escaping (((APICatMchListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param: [String: Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "district": district,
            "cat_id": cat_id,
            "page": page,
            "sort": sort
        ]
        APIService.sharedBackground.request(.catMchList(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APICatMchListResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print(APIErrorModel)
        }
    }
    
    /// 分类商品列表
    /// - Parameters:
    ///     - district: 地区
    ///     - cat_id: 分类id
    ///     - page: 第几页
    ///     - sort: 排序类型 0综合 1价格 2销量
    ///     - sort_type: 价格排序 0升序 1降序
    func catGoodsList(district: String, cat_id: String, page: Int, sort: Int, sort_type: Int = 0, _ success: @escaping (((APICatGoodsListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        var param: [String: Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "district": district,
            "cat_id": cat_id,
            "page": page,
            "sort": sort
        ]
        if (sort == 1){
            param["sort_type"] = sort_type
        }
        APIService.sharedBackground.request(.catGoodsList(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APICatGoodsListResponseModel.self, from: data)
                success(model)
            } catch {
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败--\(error)", _data: nil)
                fail(errorModel)
            }
        }) { (APIErrorModel) in
            print(APIErrorModel)
        }
    }
    
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
