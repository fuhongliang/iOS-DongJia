//
//  UBaseCollectionViewCell.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/7/30.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit
import Reusable

class UBaseCollectionViewCell: UICollectionViewCell,Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configUI() {}
    
}
