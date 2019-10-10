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
            make.bottom.equalToSuperview().offset(-9)
        }
        
    }
    
    var title:String?{
        didSet{
            guard let title = title else { return }
            caseTitle.text = title
            picture.load("https://weiliicimg9.pstatp.com/weili/l/540711875583672388.webp")
        }
    }
    
}
