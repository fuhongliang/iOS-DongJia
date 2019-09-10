//
//  JPushRegistrationID.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/7/29.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation

public func saveJPushRegistrationID(registrationID: String) {
    UserDefaults.standard.set(registrationID, forKey: "API_JPUSH_REGISTRATION")
}

public func cleanJPushRegistrationID() {
    UserDefaults.standard.set("", forKey: "API_JPUSH_REGISTRATION")
}

public func getJPushRegistrationID() -> String {
    if let registrationID = UserDefaults.standard.object(forKey: "API_JPUSH_REGISTRATION") as? String {
        if registrationID.count > 0 {
            print(" API_JPUSH_REGISTRATION--- \(registrationID)")
            return registrationID
        }
    }
    return ""
}
