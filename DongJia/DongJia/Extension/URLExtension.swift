//
//  URLExtension.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/23.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Moya

/// 解决url连接中包含'?'请求失败的问题
extension URL {
    init<T: TargetType>(t target: T) {
        if target.path.isEmpty {
            self = target.baseURL
        } else if target.path.contains("?") {
            // 这里直接强制解包了，这里可以修改，如果你需要。
            self = URL.init(string: target.baseURL.absoluteString + target.path)!
        } else {
            self = target.baseURL.appendingPathComponent(target.path)
        }
    }
}
extension MoyaProvider {
    public final class func pqEndpointMapping(for target: Target) -> Endpoint {
        return Endpoint(
            url: URL(t: target).absoluteString,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }
}
