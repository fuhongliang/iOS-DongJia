//
//  APIUser.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation

class APIUser {

    private init() {}

    public static let shared: APIUser = APIUser()

    public var user: MchInfo?

    public func saveUserToCache() {
        guard user != nil else {
            return
        }
        do {
            let data = try JSONEncoder().encode(user!)
            UserDefaults.standard.set(data, forKey: "MYiMei_USER")
        }
        catch {
            // do nothing
            print("Error")
        }
    }

    public func loadUserFromCache() {
        if let data = UserDefaults.standard.object(forKey: "MYiMei_USER") as? Data {
            do {
                user = try JSONDecoder().decode(MchInfo.self, from: data)
            }
            catch {
                print("Error")
            }
        }
    }

    public func cleanUser() {
        user = nil
        UserDefaults.standard.set("", forKey: "MYiMei_USER")
    }

}
