//
//  APIServices.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation
import Alamofire
import Moya
import MBProgressHUD
import QMUIKit

let ssl: Bool = true
//MARK:开发环境
// let baseHttpsUrl: String = "https://testjiaju.ifhu.cn"
// let baseHttpUrl: String = "https://testjiaju.ifhu.cn"
//MARK:正式环境
let baseHttpsUrl: String = "https://jiaju.ifhu.cn"
let baseHttpUrl: String = "https://jiaju.ifhu.cn"

// MARK: 网络请求加载插件
let loadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
//        QMUITips.hideAllTips(in: vc.view)
//        QMUITips.showLoading(in: vc.view)
    case .ended:
//        QMUITips.hideAllTips(in: vc.view)
        MBProgressHUD.hide(for: vc.view, animated: false)
    }
}

//MARK: 超时插件
let TimeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<NetApi>.RequestResultClosure) -> Void in

    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
    guard let vc = topVC else { return }
    MBProgressHUD.hide(for: vc.view, animated: false)
}

//MARK: 接口函数
enum NetApi {
    /// 首页数据
    case getMainData(param: [String:Any])
    /// 首页的懂家精选数据
    case getMainFeaturedData(param: [String:Any])
    /// 支持运营城市列表
    case supportCiytList(param: [String:Any])
    /// 搜索商品
    case searchGoods(param: [String:Any])
    /// 分类列表
    case catList(param: [String:Any])
    /// 分类商品列表
    case catGoodsList(param: [String:Any])
    /// 分类商家列表
    case catMchList(param: [String:Any])
    /// 微信登录接口
    case wxLogin(param: [String:Any])
    /// 我的页面数据
    case mineData(param: [String:Any])
    /// 商品详情数据
    case goodsDetail(param: [String:Any])
    /// 商品详情页的爆款推荐数据
    case goodsHotRecommend(param: [String:Any])
    /// 获取商品属性对应的数据
    case getGoodsAttrData(param: [String:Any])
    /// 店铺主页数据
    case storeInfo(param: [String:Any])
    /// 店铺精品案例
    case storeClassicCase(param: [String:Any])
    /// 添加购物车
    case addToCart(param: [String:Any])
    /// 获取购物车列表
    case getCartGoodsList(param: [String:Any])
    /// 编辑购物车商品
    case editCartGoods(param: [String:Any])
    /// 删除购物车商品
    case deleteCartGoods(param: [String:Any])
    /// 地址列表
    case addressList(param: [String:Any])
    /// 地区列表
    case districtList(param: [String:Any])
    /// 新增/更新地址
    case addOrEditAddress(param: [String:Any])
    /// 删除地址
    case deleteAddress(param: [String:Any])
    /// 下单预览
    case submitPreView(param: [String:Any])
    /// 提交订单
    case submitOrder(param: [String:Any])
    /// 获取订单支付签名
    case obtainOrderPaySign(param: [String:Any])
    /// 获取收藏列表
    case collectionList(param: [String:Any])
    /// 添加收藏商品
    case addCollectionGoods(param: [String:Any])
    /// 家装方案列表
    case dosCaseList(param: [String:Any])
    /// 家装方案详情
    case dosCaseDetail(param: [String:Any])
    /// 联系设计师
    case contactDesigner(param: [String:Any])
    /// 订单列表
    case orderList(param: [String:Any])
    /// 订单详情
    case orderDetail(param: [String:Any])
    /// 取消订单
    case cancleOrder(param: [String:Any])
}

//MARK: 请求对象的封装
extension NetApi: TargetType {
    var baseURL: URL {
        return URL(string: ssl ? baseHttpsUrl : baseHttpUrl)!
    }

    /// 返回路径时 需要动态拼接 则可以在case中添加参数
    /// 例如:get(let param)
    var path: String {
        switch self {
        case .getMainData:
            return "/index.php?r=api/default/index"
        case .getMainFeaturedData:
            return "/index.php?r=api/default/index-recommend"
        case .supportCiytList:
            return "/index.php?r=api/map/district-list"
        case .searchGoods:
            return "/index.php?r=api/default/search"
        case .catList:
            return "/index.php?r=api/default/cat-list"
        case .catGoodsList:
            return "/index.php?r=api/default/goods-list"
        case .catMchList:
            return "/index.php?r=api/default/mch-list"
        case .wxLogin:
            return "/index.php?r=api/passport/app-login"
        case .mineData:
            return "/index.php?r=api/user/index"
        case .goodsDetail:
            return "/index.php?r=api/default/goods"
        case .goodsHotRecommend:
            return "/index.php?r=api/default/goods-recommend"
        case .getGoodsAttrData:
            return "/index.php?r=api/default/goods-attr-info"
        case .storeInfo:
            return "/index.php?r=api/mch/index/shop"
        case .storeClassicCase:
            return "/index.php?r=api/default/mch-article"
        case .addToCart:
            return "/index.php?r=api/cart/add-cart"
        case .getCartGoodsList:
            return "/index.php?r=api/cart/list"
        case .editCartGoods:
            return "/index.php?r=api/cart/edit-cart"
        case .deleteCartGoods:
            return "/index.php?r=api/cart/delete"
        case .addressList:
            return "/index.php?r=api/user/address-list"
        case .districtList:
            return "/index.php?r=api/default/district"
        case .addOrEditAddress:
            return "/index.php?r=api/user/address-save"
        case .deleteAddress:
            return "/index.php?r=api/user/address-delete"
        case .submitPreView:
            return "/index.php?r=api/order/submit-preview"
        case .submitOrder:
            return "/index.php?r=api/order/submit"
        case .obtainOrderPaySign:
            return "/index.php?r=api/order/pay-data"
        case .collectionList:
            return "/index.php?r=api/user/favorite-list"
        case .addCollectionGoods:
            return "/index.php?r=api/user/favorite-add"
        case .dosCaseList:
            return "/index.php?r=api/default/topic-list"
        case .dosCaseDetail:
            return "/index.php?r=api/default/topic"
        case .contactDesigner:
            return "/index.php?r=api/user/create-user-message"
        case .orderList:
            return "/index.php?r=api/order/list"
        case .orderDetail:
            return "/index.php?r=api/order/detail"
        case .cancleOrder:
            return "/index.php?r=api/order/revoke"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMainData,.getMainFeaturedData,.supportCiytList,.searchGoods,.catList,.catGoodsList,.catMchList,.goodsDetail,.goodsHotRecommend,.storeInfo,.getGoodsAttrData,.storeClassicCase,.mineData,.getCartGoodsList,.deleteCartGoods,.addressList,.districtList,.deleteAddress,.submitPreView,.obtainOrderPaySign,.collectionList,.dosCaseList,.dosCaseDetail,.orderList,.orderDetail,.cancleOrder:
            return .get
        case .wxLogin,.addToCart,.editCartGoods,.addOrEditAddress,.submitOrder,.addCollectionGoods,.contactDesigner:
            return .post
        }
    }

    /// 用作单元测试  只在单元测试文件中有效
    var sampleData: Data {
        return Data()
    }

    
    var task: Task {
        switch self {
        case .getMainData(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .getMainFeaturedData(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .supportCiytList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .searchGoods(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .catList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .catMchList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .catGoodsList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .wxLogin(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .mineData(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .goodsDetail(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .goodsHotRecommend(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .getGoodsAttrData(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .storeInfo(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .storeClassicCase(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .addToCart(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .getCartGoodsList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .editCartGoods(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .deleteCartGoods(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .addOrEditAddress(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .districtList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .addressList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .deleteAddress(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .submitPreView(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .submitOrder(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .obtainOrderPaySign(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .collectionList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .addCollectionGoods(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .dosCaseList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .dosCaseDetail(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .contactDesigner(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
        case .orderList(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .orderDetail(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        case .cancleOrder(let param):
            return .requestParameters(parameters: param, encoding: URLEncoding.default)
        }
        
    }

    var headers: [String : String]? {
        var dict: [String:String] = [
            "Content-Type":"application/json"
        ]
        switch self {
        case .addOrEditAddress,.submitOrder,.contactDesigner:
            dict["Content-Type"] = "application/x-www-form-urlencoded"
            return dict
        default:
            return nil
        }
    }
}

class APIService {

    private init(needMBProgressHUD:Bool) {
        if (needMBProgressHUD) {
            let APIProvider = MoyaProvider<NetApi>(endpointClosure:MoyaProvider.pqEndpointMapping, plugins: [loadingPlugin,NetworkLoggerPlugin(verbose: true, cURL: true)])
            apiProvider = APIProvider
        }else {
            let APIProvider = MoyaProvider<NetApi>(endpointClosure:MoyaProvider.pqEndpointMapping, plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
            apiProvider = APIProvider
        }
    }

    public static let shared: APIService = APIService(needMBProgressHUD: true)

    public static let sharedBackground: APIService = APIService(needMBProgressHUD: false)

    private var manager: SessionManager?

    fileprivate(set) var apiProvider: MoyaProvider<NetApi>!

    func request(_ target: NetApi, _ success: @escaping ((Data) -> ()), _ fail: @escaping ((APIErrorModel) -> ())) {
        apiProvider.request(target) { (result) in
            print("--------接口响应----------------")
            switch result {
            case let .success(moyaResponse):
                do {
                    print("--- \(moyaResponse) -----")
                    let anyData = try moyaResponse.mapJSON()
                    let data =  moyaResponse.data
                    let statusCode =  moyaResponse.statusCode
                    if statusCode == 200 {
                        if let mapData: [String:Any] = anyData as? [String:Any] {
                            if mapData.keys.contains("code") { //判断接口返回是否有code字段
                                if let code = mapData["code"] as? Int { // 判断接口是否能正确解析code字段
                                    if code == 0 { // 接口正确返回
                                        success(data)
                                    } else if code == 10000 {//---服务器返回 异常状态---(token)
                                        (UIApplication.shared.delegate as! AppDelegate).showLoginView()
                                        print("返回code----10000")
                                    } else { // 接口返回其他异常情况
                                        let msg: String = mapData["msg"] as? String ?? "Error message"
                                        let errorModel = APIErrorModel.getErrorModel(_code: code, _msg: msg, _data: nil)
                                        fail(errorModel)
                                    }
                                } else { // 接口没有正确返回code字段值
                                    let errorModel = APIErrorModel.getErrorModel(_code: moyaResponse.statusCode, _msg: "Data not contain code", _data: nil)
                                    fail(errorModel)
                                }
                            } else { // 接口没有正确返回code字段值
                                let errorModel = APIErrorModel.getErrorModel(_code: moyaResponse.statusCode, _msg: "Data not contain code", _data: nil)
                                fail(errorModel)
                            }
                        } else { //返回结果不是一个字典(Json)
                            let errorModel = APIErrorModel.getErrorModel(_code: moyaResponse.statusCode, _msg: String(moyaResponse.description), _data: nil)
                            fail(errorModel)
                        }
                    }else if statusCode == 401 {//token过期
//                        (UIApplication.shared.delegate as! AppDelegate).showLoginView()
                        print("服务器返回statusCode=\(statusCode)")
                    } else { // 如果是其他返回码则处理响应的异常
                        if let mapData: [String:Any] = anyData as? [String:Any] {
                            if mapData.keys.contains("msg") {
                                if let message = mapData["msg"] as? String {
                                    let errorModel = APIErrorModel.getErrorModel(_code: moyaResponse.statusCode, _msg: message, _data: nil)
                                    fail(errorModel)
                                }
                            }

                        }else{
                            let errorModel = APIErrorModel.getErrorModel(_code: moyaResponse.statusCode, _msg: String(moyaResponse.description), _data: nil)
                            fail(errorModel)
                        }
                    }

                } catch {
                    print(error.localizedDescription)
                    let errorModel = APIErrorModel.getErrorModel(_code: moyaResponse.statusCode, _msg: nil, _data: error.localizedDescription)
                    fail(errorModel)
                }

            case let .failure(error):
                print(error.localizedDescription)
                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: nil, _data: error.failureReason)
                fail(errorModel)
            }
            guard let vc = topVC else { return }
            MBProgressHUD.hide(for: vc.view, animated: false)
            print("----------响应结束--------------")
        }
    }
}
