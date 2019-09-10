//
//  APIToken.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation

public func saveToken(token: String) {
    UserDefaults.standard.set(token, forKey: "API_TOKEN")
}

public func cleanToken() {
    UserDefaults.standard.set("", forKey: "API_TOKEN")
}

public func getToken() -> String {
    if let token = UserDefaults.standard.object(forKey: "API_TOKEN") as? String {
        if token.count > 0 {
             print(" token--- \(token)")
            return token
        }
    }
    return ""
}
