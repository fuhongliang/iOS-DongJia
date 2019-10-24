//
//  DoubleExtension.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/24.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

extension Double {
    // 保留小数位
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
