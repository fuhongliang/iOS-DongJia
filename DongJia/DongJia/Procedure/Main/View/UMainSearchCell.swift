//
//  UMainSearchCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UMainSearchCell: UBaseTableViewCell {
    
    var chooseCityAction: (() -> ())?
    var searchAction: (() -> ())?

    let cityBtn = UIButton().then {
        $0.backgroundColor = UIColor.white
        $0.setTitle("深圳", for: .normal)
        $0.setTitleColor(UIColor.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.contentHorizontalAlignment = .left
    }
    
    let downArrow = UIImageView().then {
        $0.image = UIImage.init(named: "down_arrow")
    }
    
    let search = UIButton().then {
        $0.backgroundColor = UIColor.hex(hexString: "#F5F5F5")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    let searchImg = UIImageView().then {
        $0.image = UIImage.init(named: "magnifier")
    }
    
    let searchLabel = UILabel().then {
        $0.text = "请输入关键词搜索"
        $0.textColor = UIColor.hex(hexString: "#999999")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    override func configUI() {
        
        cityBtn.addTarget(self, action: #selector(tapChooseCityAction), for: .touchUpInside)
        search.addTarget(self, action: #selector(tapSearchAction), for: .touchUpInside)
        //MARK:城市按钮
        contentView.addSubview(cityBtn)
        cityBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(55)
            make.height.equalTo(46)
            make.top.bottom.equalToSuperview()
        }
        //MARK:下箭头
        contentView.addSubview(downArrow)
        downArrow.snp.makeConstraints { (make) in
            make.centerY.equalTo(cityBtn)
            make.right.equalTo(cityBtn).offset(-15)
        }
        //MARK:搜索按钮
        contentView.addSubview(search)
        search.snp.makeConstraints { (make) in
            make.left.equalTo(cityBtn.snp.right)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        //MARK:搜索图片🔍
        contentView.addSubview(searchImg)
        searchImg.snp.makeConstraints { (make) in
            make.left.equalTo(search).offset(15)
            make.size.equalTo(15)
            make.centerY.equalTo(search)
        }
        //MARK:搜索文本
        contentView.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(search)
            make.left.equalTo(searchImg.snp.right)
        }
    }
    
    @objc func tapChooseCityAction(){
        chooseCityAction?()
    }
    
    @objc func tapSearchAction(){
        searchAction?()
    }
    
    var city : String? {
        didSet {
            guard let city = city else { return }
            cityBtn.setTitle(city, for: .normal)
        }
    }

}
