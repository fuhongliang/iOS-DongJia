//
//  UIImageViewExtension.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/8/7.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func load(_ url:String?){
        let url = URL(string: url ?? "")
        self.kf.setImage(with: url)
    }
    
}
