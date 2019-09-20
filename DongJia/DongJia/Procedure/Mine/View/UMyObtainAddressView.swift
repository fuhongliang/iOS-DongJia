//
//  UMyObtainAddressView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

protocol UMyObtainAddressViewDelegate {
    func addAddress()
}

class UMyObtainAddressView: BaseView {
    
    var delegate: UMyObtainAddressViewDelegate?
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.frame = .zero
        $0.backgroundColor = UIColor.background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.register(cellType: UObtainAddressCell.self)
    }
    
    let addNewAddress = UIButton().then{
        $0.setImage(UIImage.init(named: "add_address"), for: .normal)
        $0.setTitle("新增收货地址", for: .normal)
        $0.layoutButton(style: .Left, imageTitleSpace: 10)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17)
        $0.backgroundColor = .hex(hexString: "#0EC262")
    }
    
    
    override func configUI() {
        self.addSubview(tableView)
        self.addSubview(addNewAddress)
        addNewAddress.addTarget(self, action: #selector(tapAddAddress), for: .touchUpInside)
        //MARK:收货地址列表
        tableView.snp.makeConstraints { (make) in
            make.width.left.top.equalToSuperview()
            make.height.equalToSuperview().inset(22)
        }
        //MARK:新增收货地址
        addNewAddress.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.bottom.equalToSuperview()
        }
        
    }
    
    @objc func tapAddAddress(){
        delegate?.addAddress()
    }

}
