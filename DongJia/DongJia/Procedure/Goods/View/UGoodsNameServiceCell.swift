//
//  UGoodsNameServiceCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/28.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UGoodsNameServiceCell: UBaseTableViewCell {

    /// 商品名称
    let goodsName = UILabel().then{
        $0.text = "北欧实木黑胡桃漂浮双人床黑胡桃漂浮"
        $0.font = .boldSystemFont(ofSize: 17)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    /// 商品名称和服务的分割线
    let line = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    /// 服务Label
    let serviceLabel = UILabel().then{
        $0.text = "服务"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .hex(hexString: "#999999")
    }
    override func configUI() {
       
        
        contentView.addSubview(line)
        contentView.addSubview(goodsName)
        contentView.addSubview(serviceLabel)
        
        //MARK:商品名称
        goodsName.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15)
            make.width.equalToSuperview().inset(15)
        }
        //MARK:分割线
        line.snp.makeConstraints { (make) in
            make.top.equalTo(goodsName.snp.bottom).offset(15)
            make.height.equalTo(1)
            make.width.equalToSuperview().inset(7.5)
            make.left.equalToSuperview().offset(15)
        }
        //MARK:服务Label
        serviceLabel.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.top.equalTo(line.snp.bottom)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
        }
        
    }
    
    /// 生成一个服务标签🏷
    func getService(_ name: String) -> UIView{
        let bg = UIView()
        let point = UIView().then{
            $0.backgroundColor = .theme
            $0.layer.cornerRadius = 1.5
            $0.layer.masksToBounds = true
        }
        let serviceName = UILabel().then{
            $0.text = name
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = .hex(hexString: "#666666")
        }
        bg.addSubview(point)
        bg.addSubview(serviceName)
        //MARK:绿色点
        point.snp.makeConstraints { (make) in
            make.size.equalTo(3)
            make.centerY.left.equalToSuperview()
        }
        //MARK:服务
        serviceName.snp.makeConstraints { (make) in
            make.left.equalTo(point.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        return bg
    }
    
    var serviceData:[String]? {
        didSet{
            guard let serviceData = serviceData else { return }
            var label:[UIView] = []
            for (index, service) in serviceData.enumerated() {
                label.append(getService(service))
                contentView.addSubview(label[index])
                label[index].snp.makeConstraints { (make) in
                    make.width.equalTo(80)
                    make.height.equalTo(44)
                    make.top.equalTo(line.snp.bottom)
                    make.left.equalTo(serviceLabel.snp.right).offset(index * 80 + 21)
                }
            }
            
        }
    }

}
