//
//  UDesignTeamCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/11.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UDesignTeamCell: UBaseCollectionViewCell {
    
    /// 设计师头像
    let designerIcon = UIImageView().then{
        $0.layer.cornerRadius = 22.5
        $0.layer.masksToBounds = true
    }
    /// 设计师名字
    let designerName = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 12)
    }
    /// 设计经验
    let designExperience = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 10)
    }
    
    override func configUI() {
    
        contentView.addSubview(designerIcon)
        contentView.addSubview(designerName)
        contentView.addSubview(designExperience)
        
        //MARK:设计师头像
        designerIcon.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(45)
        }
        //MARK:设计师名字
        designerName.snp.makeConstraints { (make) in
            make.top.equalTo(designerIcon.snp.bottom).offset(7.5)
            make.centerX.equalTo(designerIcon)
        }
        //MARK:设计经验
        designExperience.snp.makeConstraints { (make) in
            make.top.equalTo(designerName.snp.bottom).offset(6.5)
            make.centerX.equalTo(designerName)
        }
    }
    
    var designerInfo: String?{
        didSet{
            guard designerInfo != nil else { return }
            designerIcon.image = UIImage.init(named: "default_icon_2")
            designerName.text = "于亿鑫"
            designExperience.text = "8年设计经验"
        }
    }
    
}
