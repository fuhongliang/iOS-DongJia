//
//  BaseView.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/6/24.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit
import Then

class BaseView: UIView {
    //Nothing to do in here now
    
    init() {
        super.init(frame: CGRect.init())
        self.isUserInteractionEnabled = true
        self.configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {
        
    }
    
}
