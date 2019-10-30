//
//  UPrimaryClassificationCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/30.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UPrimaryClassificationCell: UBaseTableViewCell {
    
    /// 选中后的颜色块
    let colorPiece = UIView().then{
        $0.backgroundColor = .theme
        $0.isHidden = true
    }
    /// 一级分类名称
    let classificationName = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 13)
    }
    
    override func configUI() {
        
        contentView.addSubview(colorPiece)
        contentView.addSubview(classificationName)
        
        //MARK:颜色块
        colorPiece.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 3, height: 22))
            make.left.centerY.equalToSuperview()
        }
        
        //MARK:名称
        classificationName.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            colorPiece.isHidden = false
            classificationName.font = .boldSystemFont(ofSize: 13)
            contentView.backgroundColor = .white
        } else {
            colorPiece.isHidden = true
            classificationName.font = .systemFont(ofSize: 13)
            contentView.backgroundColor = .background
        }
        
    }
    
    var name: String = "" {
        didSet{
            classificationName.text = name
        }
    }

}
