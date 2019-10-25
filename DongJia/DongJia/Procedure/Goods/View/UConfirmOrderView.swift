//
//  UConfirmOrderView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UConfirmOrderView: BaseView {

    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = UIColor.background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionFooterHeight = .leastNormalMagnitude
        $0.register(cellType: UConfirmOrderAddressCell.self)
        $0.register(cellType: UOrderGoodsInfoCell.self)
        $0.register(cellType: UMainClassificationCell.self)
        $0.register(cellType: UMainLimitedCell.self)
        $0.register(cellType: UMainHotCell.self)
        $0.register(cellType: UMainSuperBrandCell.self)
        $0.register(cellType: UMainFeaturedCell.self)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .hex(hexString: "#E6E6E6")
    }
    /// 底部的布局
    let bottomView = UIView().then{
        $0.backgroundColor = .white
    }
    /// 总付文本
    let allLabel = UILabel().then{
        $0.text = "总付:"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 17)
    }
    /// 价格文本
    let priceLabel = UILabel().then{
        $0.textColor = .hex(hexString: "#FD5757")
        $0.font = .systemFont(ofSize: 17)
    }
    /// 提交订单
    let postOrder = UIButton().then{
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.setTitle("提交订单", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .hex(hexString: "#0EC262")
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    
    override func configUI() {
        
        self.addSubview(tableView)
        
        self.addSubview(bottomView)
        bottomView.addSubview(line)
        bottomView.addSubview(allLabel)
        bottomView.addSubview(priceLabel)
        bottomView.addSubview(postOrder)
        
        //MARK:列表
        tableView.snp.makeConstraints { (make) in
            make.width.top.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-54)
        }
        
        //MARK:底部布局
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.width.equalToSuperview()
            make.height.equalTo(54)
        }
        
        //MARK:分割线
        line.snp.makeConstraints { (make) in
            make.top.width.left.equalToSuperview()
            make.height.equalTo(0.5)
        }
        //MARK:已付
        allLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        //MARK:价格
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(allLabel.snp.right)
            make.centerY.equalToSuperview()
        }
        //MARK:提交订单
        postOrder.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 110, height: 40))
            make.centerY.equalToSuperview()
        }
    }
    
    var allPayPrice: String = "¥-"{
        didSet{
            priceLabel.text = "¥\(allPayPrice)"
        }
    }

}
