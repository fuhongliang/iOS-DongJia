//
//  UClassicCaseCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UClassicCaseCell: UBaseCollectionViewCell {
    /// 案例图片
    let picture = UIImageView()
    /// 案例名称
    let caseTitle = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 13)
    }
    override func configUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 3
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(picture)
        contentView.addSubview(caseTitle)
        
        //MARK:案例图片
        picture.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(collectionCellWidth)
            make.height.equalTo(130)
        }
        
        //MARK:案例名称
        caseTitle.snp.makeConstraints { (make) in
            make.top.equalTo(picture.snp.bottom).offset(9)
            make.left.right.equalToSuperview().offset(7)
            
        }
        let view = UIView()
        contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(caseTitle.snp.bottom).offset(9)
            make.bottom.equalToSuperview()
        }
        
    }
    
    var data:store_classic_case_model?{
        didSet{
            guard let data = data else { return }
            caseTitle.text = data.title
            picture.load(data.cover_pic)
        }
    }
    
}
