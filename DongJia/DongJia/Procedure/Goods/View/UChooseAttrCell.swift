//
//  UChooseAttrCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/16.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UChooseAttrCell: UBaseCollectionViewCell {
    
    let attrName = UILabel().then{
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 13)
    }
    
    
    
    override func configUI() {
        
        contentView.layer.cornerRadius = 2
        contentView.layer.masksToBounds = true
        contentView.addSubview(attrName)
        //MARK:城市名称
        attrName.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(-7)
            make.centerY.equalToSuperview()
        }
        
    }
    
    //是否选中当前商品属性
    var isChoose: Bool = false {
        didSet{
            if isChoose {
                contentView.backgroundColor = .hex(hexString: "#0EC262")
                attrName.textColor = .white
            } else {
                contentView.backgroundColor = .hex(hexString: "#F5F5F5")
                attrName.textColor = .black
            }
        }
    }
    
    var name: String = ""{
        didSet{
            attrName.text = name
        }
    }
}
