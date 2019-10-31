//
//  USecondartClassificationCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/30.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class USecondartClassificationCell: UBaseCollectionViewCell {
    /// 分类图片
    let classificationImg = UIImageView()
    
    /// 分类名称
    let classificationName = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 11)
    }
    
    override func configUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(classificationImg)
        contentView.addSubview(classificationName)
        
        //MARK:分类图片
        classificationImg.snp.makeConstraints { (make) in
            make.size.equalTo(60)
            make.center.equalToSuperview()
        }
        
        //MARK:分类名称
        classificationName.snp.makeConstraints { (make) in
            make.top.equalTo(classificationImg.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
    
    var classificationData: secondart_list_model?{
        didSet{
            guard let data = classificationData else { return }
            classificationName.text = data.name
            classificationImg.load(data.pic_url)
        }
    }
    
}
