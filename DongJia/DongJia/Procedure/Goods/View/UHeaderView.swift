//
//  UHeaderView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/16.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import Reusable

class UHeaderView: UICollectionReusableView,Reusable {
    
    let attrGroupName = UILabel().then{
        $0.text = "颜色"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 17)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.backgroundColor = .clear
        self.addSubview(attrGroupName)
        //MARK:规格组名
        attrGroupName.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
    }
    
}
