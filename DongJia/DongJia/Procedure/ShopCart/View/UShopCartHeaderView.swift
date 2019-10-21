//
//  UShopCartHeaderView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/21.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UShopCartHeaderView: BaseView {
    
    var delegate: ShopCartDelegate?
    
    var section:Int = 0

    let whiteBg = UIView().then{
        $0.backgroundColor = .white
    }
    
    /// 选择按钮
    let selectBtn = UIButton().then{
        $0.setImage(UIImage.init(named: "select_default_address"), for: .selected)
        $0.setImage(UIImage.init(named: "not_select_default_address"), for: .normal)
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
        whiteBg.addSubview(selectBtn)
        whiteBg.addSubview(storeIcon)
        whiteBg.addSubview(storeName)
        whiteBg.addSubview(line)
        
        selectBtn.addTarget(self, action: #selector(selectSection), for: .touchUpInside)
        
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(59)
        }
        
        //MARK:选择按钮
        selectBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()//.offset(13)
            make.height.equalTo(44)
            make.width.equalTo(46)
//            make.size.equalTo(18)
            make.left.equalToSuperview()//.offset(15)
        }
        
        //MARK:商家头像
        storeIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(selectBtn)
            make.left.equalTo(selectBtn.snp.right)
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
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    /// 选择/取消选择一组
    @objc func selectSection(){
        selectBtn.isSelected = !selectBtn.isSelected
        delegate?.selectSection(section: section, check: selectBtn.isSelected)
    }

    var isCheck: Bool = false {
        didSet{
            selectBtn.isSelected = isCheck
        }
    }
    
}
