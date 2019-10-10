//
//  APIGoodsService.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/9.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIGoodsServiceProtocol {
    func getGoodsDetail(storeId: String, goodsId: String, _ success: @escaping(((APIGoodsDetailResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func getGoodsRecommend(goodsId: String, _ success: @escaping(((APIGoodsRecommendResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIGoodsService: APIGoodsServiceProtocol {
    /// 获取商品详情中的爆款推荐数据
    func getGoodsRecommend(goodsId: String, _ success: @escaping (((APIGoodsRecommendResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "goods_id": goodsId
        ]
        APIService.sharedBackground.request(.goodsHotRecommend(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIGoodsRecommendResponseModel.self, from: data)
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
    
    /// 获取商品详情数据
    func getGoodsDetail(storeId: String, goodsId: String, _ success: @escaping (((APIGoodsDetailResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        var param:[String:Any] = [
            "store_id": storeId,
            "_uniacid": -1,
            "_acid": -1,
            "id": goodsId
        ]
        if let access_token = APIUser.shared.user?.access_token {
            param["access_token"] = access_token
        }
        APIService.sharedBackground.request(.goodsDetail(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIGoodsDetailResponseModel.self, from: data)
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
