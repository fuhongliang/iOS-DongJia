//
//  UChooseCityCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UChooseCityCell: UBaseCollectionViewCell {
    
    let cityName = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 13)
    }
    
    override func configUI() {
        
        contentView.backgroundColor = .hex(hexString: "#F5F5F5")
        
        contentView.addSubview(cityName)
        //MARK:城市名称
        cityName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    var city: String = ""{
        didSet{
            cityName.text = city
        }
    }
    
}
