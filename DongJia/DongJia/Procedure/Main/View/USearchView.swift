//
//  USearchView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class USearchView: BaseView {
    
    let searchBg = UIView().then {
        $0.backgroundColor = UIColor.hex(hexString: "#F5F5F5")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    let searchImg = UIImageView().then {
        $0.image = UIImage.init(named: "magnifier")
    }
    
    let searchTf = UITextField().then {
        $0.placeholder = "请输入关键词搜索"
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let clearBtn = UIButton().then {
        $0.setImage(UIImage.init(named: "delete_address"), for: .normal)
    }
    
    let searchBtn = UIButton().then{
        $0.setTitle("搜索", for: .normal)
        $0.setTitleColor(.theme, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }

    override func configUI() {
//        let searchBtn = UIButton().then{
//            $0.setTitle("搜索", for: .normal)
//            $0.setTitleColor(.theme, for: .normal)
//            $0.titleLabel?.font = .systemFont(ofSize: 13)
//        }
        self.backgroundColor = .white
        self.addSubview(searchBg)
        searchBg.addSubview(searchImg)
        searchBg.addSubview(searchTf)
        searchBg.addSubview(clearBtn)
        self.addSubview(searchBtn)
        
        //MARK:灰色圆角搜索背景
        searchBg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: screenWidth-80,height: 30))
        }
        //MARK:🔍放大镜
        searchImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(15)
            make.centerY.equalToSuperview()
        }
        //MARK:输入框
        searchTf.snp.makeConstraints { (make) in
            make.left.equalTo(searchImg.snp.right).offset(10)
            make.height.top.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
        }
        //MARK:清空输入
        clearBtn.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.right.centerY.equalToSuperview()
        }
        clearBtn.addTarget(self, action: #selector(clearSearchAction), for: .touchUpInside)
        //MARK:搜索
        searchBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width:70, height: 40))
            make.right.equalToSuperview()
            make.centerY.equalTo(searchBg)
        }
        searchBtn.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
    }
    
    @objc func clearSearchAction(){
        searchTf.text = ""
    }
    @objc func searchAction(){
        showHUDInView(text: searchTf.text ?? "", inView: self, isClick: true)
    }

}
