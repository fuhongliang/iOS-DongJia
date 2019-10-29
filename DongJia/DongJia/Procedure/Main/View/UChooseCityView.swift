//
//  UChooseCityView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UChooseCityView: BaseView {
    let location = UIImageView().then{
        $0.image = UIImage.init(named: "gps_img")
    }
    
    let currentLabel = UILabel().then{
        $0.text = "当前选择城市"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 当前选择的城市
    let currentCity = UILabel().then{
        $0.textColor = .hex(hexString: "#0EC262")
        $0.font = .systemFont(ofSize: 14)
    }
    let currentCityLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    /// 业务覆盖城市
    let businessCoverCity = UILabel().then{
        $0.text = "业务覆盖城市"
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 12)
    }
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.bounces = false
        
        $0.register(cellType: UChooseCityCell.self)
    }
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical //设置滚动方向
        $0.estimatedItemSize = CGSize(width: (screenWidth-75)/4, height: 30)
        $0.itemSize = CGSize(width: (screenWidth-75)/4, height: 30)//设置cell的大小
        $0.minimumInteritemSpacing = 7.5
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    override func configUI() {
        
        collectionView.collectionViewLayout = layout
        backgroundColor = .white
        self.addSubview(currentCityLine)
        self.addSubview(location)
        self.addSubview(currentLabel)
        self.addSubview(currentCity)
        self.addSubview(businessCoverCity)
        self.addSubview(collectionView)
        
        //MARK:分割线
        currentCityLine.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(44)
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        //MARK:定位图片
        location.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 11, height: 14))
        }
        //MARK:当前定位城市
        currentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(location.snp.right).offset(10)
            make.centerY.equalTo(location)
        }
        //MARK:城市
        currentCity.snp.makeConstraints { (make) in
            make.left.equalTo(currentLabel.snp.right)
            make.centerY.equalTo(location)
        }
        
        //MARK:业务覆盖城市
        businessCoverCity.snp.makeConstraints { (make) in
            make.top.equalTo(currentCityLine.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(15)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(businessCoverCity.snp.bottom).offset(10)
            make.bottom.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(15)
        }
        
    }

}


