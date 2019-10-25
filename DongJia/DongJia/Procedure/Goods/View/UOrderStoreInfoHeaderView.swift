//
//  UOrderStoreInfoHeaderView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UOrderStoreInfoHeaderView: BaseView{
    
    let whiteBg = UIView().then{
        $0.backgroundColor = .white
    }
    /// 商家头像👤
    let storeIcon = UIImageView().then{
        $0.image = UIImage.init(named: "default_icon_2")
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    /// 商家名称
    let storeName = UILabel().then{
        $0.text = "送福利"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
    }
    /// 分割线
    let line = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    override func configUI() {
        
       
        self.addSubview(whiteBg)
        whiteBg.addSubview(storeIcon)
        whiteBg.addSubview(storeName)
        whiteBg.addSubview(line)
        
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.bottom.width.equalToSuperview()
            make.height.equalTo(44)
        }
        
        //MARK:商家头像
        storeIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
            make.size.equalTo(20)
        }
        
        //MARK:商家名称
        storeName.snp.makeConstraints { (make) in
            make.centerY.equalTo(storeIcon)
            make.left.equalTo(storeIcon.snp.right).offset(15)
        }
        //MARK:分割线
        line.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: screenHeight-15, height: 1))
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
        }
    }
    
    var mchData: submit_view_mch_list_model?{
        didSet{
            guard let mch = mchData else { return }
            storeIcon.load(mch.logo)
            storeName.text = mch.name
        }
    }

}
