//
//  UMainSearchCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit

class UMainSearchCell: UBaseTableViewCell {
    
    var chooseCityAction: (() -> ())?
    var searchAction: (() -> ())?

    let cityBtn = QMUIButton().then{
        $0.backgroundColor = UIColor.white
        $0.setTitle("深圳", for: .normal)
        $0.setTitleColor(UIColor.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.imagePosition = .right
        $0.setImage(UIImage.init(named: "down_arrow"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
    }
    
    let search = QMUIButton().then{
        $0.backgroundColor = .hex(hexString: "#F5F5F5")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.setTitle("请输入关键词搜索", for: .normal)
        $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.imagePosition = .left
        $0.setImage(UIImage.init(named: "magnifier"), for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        $0.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 0)
        $0.contentHorizontalAlignment = .left
    }
    
    override func configUI() {

        cityBtn.addTarget(self, action: #selector(tapChooseCityAction), for: .touchUpInside)
        search.addTarget(self, action: #selector(tapSearchAction), for: .touchUpInside)
        //MARK:城市按钮
        contentView.addSubview(cityBtn)
        cityBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 60, height: 46))
            make.top.bottom.equalToSuperview()
        }
        //MARK:搜索按钮
        contentView.addSubview(search)
        search.snp.makeConstraints { (make) in
            make.left.equalTo(cityBtn.snp.right).offset(5)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
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
