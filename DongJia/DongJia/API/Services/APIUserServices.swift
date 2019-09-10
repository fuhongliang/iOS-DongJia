//
//  APIUserServices.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation
import UIKit

protocol APIUserServicesProtocol {
    //登录协议
    func login(phoneNumber: String, password: String,jpush_registration_id: String, _ success: @escaping(((APILoginResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))

    //退出登录协议
    func logout(userId: String, _ success: @escaping((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))

    //获取登录验证码

    func getLoginMsg(phoneNumber:String,_ success: @escaping(((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))

//    //上传图片专用
//    func uploadPic(ext:String,type:String,size:Int,image:String,_ success: @escaping(((UploadFileResponeModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
//
//    //提交申请
//    func applyJoin(mchApplyModel: MchApplyModel, _ success: @escaping(((MchApplyResponeModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
//
//    func getApplyCat(_ success: @escaping(((ApplyCatModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
//
//    //获取验证码
//    func getVerification(username: String, _ success: @escaping((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
//
//    //修改密码
//    func modifyPwd(mch_id: Int, access_token: String, phone: String, code: String, password: String, _ success: @escaping((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
//    //获取店铺信息
//    func storeInfo( _ success: @escaping(((StoreInfoModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))
//    //店铺设置
//    func modifyStoreInfo(param: String,paramValue: String, _ success: @escaping((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void))

}

class APIUserServices: APIUserServicesProtocol {
    func modifyStoreInfo(param: String,paramValue: String, _ success: @escaping ((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let params: [String:Any] = [
            "mch_id":APIUser.shared.self.user?.mch_id as Any,
            "access_token":APIUser.shared.self.user?.access_token as Any,
            "is_debug":"1",
            param:paramValue
        ]
//        APIService.shared.request(.modifyStoreInfo(param: params), { (data) in
//                success()
//        }) { (error) in
//            fail(error)
//        }
    }
    
    func getLoginMsg(phoneNumber: String, _ success: @escaping (((APIObjectModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let params: [String:String] = [
            "username":phoneNumber,
            "is_debug":"1"
        ]
//        APIService.shared.request(.getLoginMsg(user: params), { (data) in
//            do {
//                let model = try JSONDecoder().decode(APIObjectModel.self, from: data)
//                success(model)
//            }
//            catch {
//                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败", _data: nil)
//                fail(errorModel)
//            }
//        }) { (error) in
//            fail(error)
//        }
        
    }
    
    func getVerification(username: String, _ success: @escaping ((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let params: [String:Any] = [
            "mch_id":APIUser.shared.user?.mch_id as Any,
            "username":username,
            "access_token":APIUser.shared.user?.access_token as Any,
            "is_debug":"1"
        ]
//        APIService.shared.request(.getChangePasswordVerificationCode(param: params), { (data) in
//            success()
//        }) { (error) in
//            fail(error)
//        }
    }
    
    func modifyPwd(mch_id: Int, access_token: String, phone: String, code: String, password: String, _ success: @escaping ((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let params: [String:Any] = [
            "mch_id":String(mch_id),
            "is_debug":"1",
            "access_token":access_token,
            "phone":phone,
            "code":code,
            "password":password
        ]
        
//        APIService.shared.request(.modifyPwd(param: params), { (data) in
//            success()
//        }) { (error) in
//            fail(error)
//        }
//
    }


//
//    func applyJoin(mchApplyModel: MchApplyModel, _ success: @escaping (((MchApplyResponeModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
//
//        var params: [String:Any] = [
//            "mch_id":APIUser.shared.user?.mch_id as Any,
//            "access_token":APIUser.shared.user?.access_token as Any,
//            "is_debug":"1"
//        ]
//
//        let mirror: Mirror = Mirror(reflecting:mchApplyModel)
//
//        for p in mirror.children {
//             //属性名使用!，因为label是optional类型
//            let propertyNameString = p.label!
//            //属性的值
//            let value = p.value
//            params.updateValue(value, forKey: propertyNameString)
//        }
//
//
//        APIService.shared.request(.applyJoin(param: params), { (data) in
//            do {
//                let model = try JSONDecoder().decode(MchApplyResponeModel.self, from: data)
//                success(model)
//            }
//            catch {
//                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败", _data: nil)
//                fail(errorModel)
//            }
//        }) { (error) in
//            fail(error)
//        }
//    }
    
//    func uploadPic(ext: String, type: String, size: Int, image: String, _ success: @escaping (((UploadFileResponeModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
//        let params: [String:Any] = [
//            "mch_id":APIUser.shared.user?.mch_id as Any,
//            "access_token":APIUser.shared.user?.access_token as Any,
//            "ext":ext,
//            "type":type,
//            "size":size,
//            "image":image,
//            "is_debug":"1"
//        ]
//        APIService.shared.request(.uploadPic(param: params), { (data) in
//            do {
//                let model = try JSONDecoder().decode(UploadFileResponeModel.self, from: data)
//                success(model)
//            }
//            catch {
//                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败", _data: nil)
//                fail(errorModel)
//            }
//        }) { (error) in
//            fail(error)
//        }
//    }

    //登录实现
    func login(phoneNumber: String, password: String, jpush_registration_id: String, _ success: @escaping (((APILoginResponseModel) -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {
        let params: [String:String] = [
            "username":phoneNumber,
            "password":password,
            "jpush_registration_id":jpush_registration_id,
            "is_debug":"1"
        ]
        
//        APIService.shared.request(.login(user: params), { (data) in
//            do {
//                let model = try JSONDecoder().decode(APILoginResponseModel.self, from: data)
//                if let token = model.data?.mch_info?.access_token {
//                    saveToken(token: token)
//                    APIUser.shared.user = model.data?.mch_info
//                    APIUser.shared.saveUserToCache()
//                }
//                success(model)
//            }
//            catch {
//                let errorModel = APIErrorModel.getErrorModel(_code: nil, _msg: "解析失败", _data: nil)
//                fail(errorModel)
//            }
//        }) { (error) in
//            fail(error)
//        }
    }

    //退出登录实现
    func logout(userId: String, _ success: @escaping ((() -> Void)), _ fail: @escaping ((APIErrorModel) -> Void)) {

    }


}
