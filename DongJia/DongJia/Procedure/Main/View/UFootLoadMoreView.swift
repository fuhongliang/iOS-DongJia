//
//  UFootLoadMoreView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/26.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

class UFootLoadMoreView: UBaseCollectionViewCell {
    
    let loadText = UILabel().then{
        $0.text = "正在获取更多精选数据"
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    override func configUI() {
    
        contentView.addSubview(loadText)
        
        loadText.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        
    }
    
}
