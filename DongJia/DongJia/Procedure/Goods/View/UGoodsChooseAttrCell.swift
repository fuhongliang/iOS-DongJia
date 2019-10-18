//
//  UGoodsChooseAttrCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UGoodsChooseAttrCell: UBaseTableViewCell {

    /// 选择Label
    let chooseLabel = UILabel().then{
        $0.text = "选择"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .hex(hexString: "#999999")
    }
    /// 规格名Label
    let attrNameLabel = UILabel().then{
        $0.text = "颜色 尺码"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .hex(hexString: "#010101")
    }
    let rightArrow = UIImageView().then{
        $0.image = UIImage.init(named: "right_arrow")
    }
    
    override func configUI() {
        
        contentView.addSubview(chooseLabel)
        contentView.addSubview(attrNameLabel)
        contentView.addSubview(rightArrow)
        
        //MARK:选择
        chooseLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(44)
        }
        //MARK:规格名
        attrNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(chooseLabel.snp.right).offset(21)
            make.centerY.equalToSuperview()
        }
        //MARK:右箭头
        rightArrow.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(8)
            make.height.equalTo(13.5)
            make.centerY.equalToSuperview()
        }
    }
    
    var chooseAttr: goods_attr_data?{
        didSet{
            guard let chooseAttr = chooseAttr else { return }
            var string = ""
            for item in chooseAttr.attr_list{
                string += "   \"\(item.attr_name)\""
            }
            attrNameLabel.text = "已选\(string)"
        }
    }
    
}
