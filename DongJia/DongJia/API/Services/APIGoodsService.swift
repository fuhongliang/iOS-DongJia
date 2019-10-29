//
//  APIGoodsService.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/9.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIGoodsServiceProtocol {
    /// 获取商品详情
    func getGoodsDetail(storeId: String, goodsId: String, _ success: @escaping(((APIGoodsDetailResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    /// 获取精选数据
    func getGoodsRecommend(goodsId: String, _ success: @escaping(((APIGoodsRecommendResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    /// 获取商品属性 attr_list -> 选择的商品属性ID
    func getGoodsAttrData(goodsId: String, attr_list:[Int], _ success: @escaping(((APIGoodsAttrDataResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    /// 添加到购物车 attr -> 商品属性json
    func addToCart(goods_id: String, num: Int, attr: String, _ success: @escaping(((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    /// 获取购物车中的商品列表
    func getCartGoodsList(_ success: @escaping(((APIShopCartListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    /// 编辑购物车中的商品
    func editCartGoods(cart_id_list:String, _ success: @escaping(((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    /// 删除购物车中的商品
    func deleteCartGoods(cart_id_list: String, _ success: @escaping(((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
}

class APIGoodsService: APIGoodsServiceProtocol {
    func deleteCartGoods(cart_id_list: String, _ success: @escaping (((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "cart_id_list": cart_id_list,
            "access_token": APIUser.shared.user!.access_token
        ]
        APIService.sharedBackground.request(.deleteCartGoods(param: param), { (data) in
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
    
    func editCartGoods(cart_id_list: String, _ success: @escaping (((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "cart_id_list": cart_id_list,
            "access_token": APIUser.shared.user!.access_token
        ]
        APIService.sharedBackground.request(.editCartGoods(param: param), { (data) in
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
    
    func getCartGoodsList(_ success: @escaping (((APIShopCartListResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user!.access_token
        ]
        APIService.sharedBackground.request(.getCartGoodsList(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIShopCartListResponseModel.self, from: data)
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
    
    func addToCart(goods_id: String, num: Int, attr: String, _ success: @escaping (((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user!.access_token,
            "goods_id": goods_id,
            "num": num,
            "attr":"\(attr)"
        ]
        APIService.sharedBackground.request(.addToCart(param: param), { (data) in
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
    
    func getGoodsAttrData(goodsId: String, attr_list: [Int], _ success: @escaping (((APIGoodsAttrDataResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param:[String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "goods_id": goodsId,
            "attr_list":"\(attr_list)"
        ]
        APIService.sharedBackground.request(.getGoodsAttrData(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIGoodsAttrDataResponseModel.self, from: data)
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
