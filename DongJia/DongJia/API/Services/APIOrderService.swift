//
//  APIOrderService.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/24.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

protocol APIOrderServiceProtocol {
    
    func submitPreView(cart_id_list: [Int], mch_list: String, goods_info: String, _ success: @escaping(((APIOrderSubmitViewResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func submitOrder(address_id: String, cart_id_list: String, mch_list: String, payment: Int, _ success: @escaping(((APISubmitOrderResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
    func obtainOrderPaySign(order_id: Int?, order_id_list: [Int]?, _ success: @escaping(((APIOrderPayDataResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
    
}

class APIOrderService: APIOrderServiceProtocol{
    func obtainOrderPaySign(order_id: Int?, order_id_list: [Int]?, _ success: @escaping (((APIOrderPayDataResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        var param: [String:Any] = [
            "access_token": APIUser.shared.user!.access_token,
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "pay_type": "WECHAT_PAY",
            "app_key":"app"
        ]
        if order_id != nil {
            param["order_id"] = order_id
        }
        if !(order_id_list?.isEmpty ?? true){
            param["order_id_list"] = toJson(order_id_list!)
        }
        APIService.shared.request(.obtainOrderPaySign(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIOrderPayDataResponseModel.self, from: data)
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
    
    
    /// 提交订单接口
    /// - Parameters:
    ///     - address_id: 地址ID
    ///     - cart_id_list: 自营商品 购物车ID
    ///     - mch_lsit: 商家商品 商家ID,购物车ID
    ///     - payment: 支付方式 0 微信支付 1 余额支付
    func submitOrder(address_id: String, cart_id_list: String, mch_list: String, payment: Int, _ success: @escaping (((APISubmitOrderResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let param: [String:Any] = [
            "access_token": APIUser.shared.user!.access_token,
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "address_id": address_id,
            "cart_id_list": cart_id_list,
            "mch_list": mch_list,
            "payment": payment
        ]
        APIService.shared.request(.submitOrder(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APISubmitOrderResponseModel.self, from: data)
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
    
    
    /// 下单预览接口
    func submitPreView(cart_id_list: [Int], mch_list: String, goods_info: String, _ success: @escaping (((APIOrderSubmitViewResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        var param: [String:Any] = [
            "store_id": 4,
            "_uniacid": -1,
            "_acid": -1,
            "access_token": APIUser.shared.user!.access_token
        ]
        if (!cart_id_list.isEmpty){
            param["cart_id_list"] = cart_id_list
        }
        if (!mch_list.isEmpty){
            param["mch_list"] = mch_list
        }
        if (!goods_info.isEmpty){
            param["goods_info"] = goods_info
        }
        APIService.shared.request(.submitPreView(param: param), { (data) in
            do {
                let model = try JSONDecoder().decode(APIOrderSubmitViewResponseModel.self, from: data)
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
