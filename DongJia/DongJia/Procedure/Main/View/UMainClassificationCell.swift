//
//  UMainClassificationCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/11.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UMainClassificationCell: UBaseTableViewCell {
    
    var buildingMaterialsAction: (() -> ())?
    var residentialFurnitureAction: (() -> ())?
    var domesticInstallationAction: (() -> ())?
    var householdAppliancesAction: (() -> ())?
    var toViewMoreAction: (() -> ())?
    
    var classificationBg = UIView().then{
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    var buildingMaterialsBtn = UIButton()
    var residentialFurnitureBtn = UIButton()
    var domesticInstallationBtn = UIButton()
    var householdAppliancesBtn = UIButton()
    var toViewMoreBtn = UIButton()
    
    var buildingMaterialsImg = UIImageView().then{
        $0.image = UIImage.init(named: "building_materials")
    }
    var residentialFurnitureImg = UIImageView().then{
        $0.image = UIImage.init(named: "residential_furniture")
    }
    var domesticInstallationImg = UIImageView().then{
        $0.image = UIImage.init(named: "domestic_installation")
    }
    var householdAppliancesImg = UIImageView().then{
        $0.image = UIImage.init(named: "household_appliances")
    }
    var toViewMoreImg = UIImageView().then{
        $0.image = UIImage.init(named: "to_view_more")
    }
    
    var buildingMaterialsLabel = UILabel().then{
        $0.text = "建材"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.hex(hexString: "#333333")
        
    }
    var residentialFurnitureLabel = UILabel().then{
        $0.text = "住宅家具"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.hex(hexString: "#333333")
    }
    var domesticInstallationLabel = UILabel().then{
        $0.text = "家政安装"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.hex(hexString: "#333333")
    }
    var householdAppliancesLabel = UILabel().then{
        $0.text = "家用电器"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.hex(hexString: "#333333")
    }
    var toViewMoreLabel = UILabel().then{
        $0.text = "查看更多"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.hex(hexString: "#333333")
    }
    override func configUI() {
        contentView.backgroundColor = UIColor.background
        contentView.addSubview(classificationBg)
        
        contentView.addSubview(buildingMaterialsBtn)
        buildingMaterialsBtn.addSubview(buildingMaterialsImg)
        buildingMaterialsBtn.addSubview(buildingMaterialsLabel)
        
        contentView.addSubview(residentialFurnitureBtn)
        residentialFurnitureBtn.addSubview(residentialFurnitureImg)
        residentialFurnitureBtn.addSubview(residentialFurnitureLabel)
        
        contentView.addSubview(domesticInstallationBtn)
        domesticInstallationBtn.addSubview(domesticInstallationImg)
        domesticInstallationBtn.addSubview(domesticInstallationLabel)
        
        contentView.addSubview(householdAppliancesBtn)
        householdAppliancesBtn.addSubview(householdAppliancesImg)
        householdAppliancesBtn.addSubview(householdAppliancesLabel)
        
        contentView.addSubview(toViewMoreBtn)
        toViewMoreBtn.addSubview(toViewMoreImg)
        toViewMoreBtn.addSubview(toViewMoreLabel)
        
        buildingMaterialsBtn.addTarget(self, action: #selector(tapBuildingMaterialsAction), for: .touchUpInside)
        residentialFurnitureBtn.addTarget(self, action: #selector(tapResidentialFurnitureAction), for: .touchUpInside)
        domesticInstallationBtn.addTarget(self, action: #selector(tapDomesticInstallationAction), for: .touchUpInside)
        householdAppliancesBtn.addTarget(self, action: #selector(tapHouseholdAppliancesAction), for: .touchUpInside)
        toViewMoreBtn.addTarget(self, action: #selector(tapToViewMoreAction), for: .touchUpInside)
        
        classificationBg.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(82.5)
        }
        //MARK:建材按钮
        buildingMaterialsBtn.snp.makeConstraints { (make) in
            make.width.equalTo(classificationBg).dividedBy(5)
            make.height.left.top.equalTo(classificationBg)
        }
        //MARK:建材图片
        buildingMaterialsImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.size.equalTo(38)
        }
        //MARK:建材文本
        buildingMaterialsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(buildingMaterialsImg.snp.bottom).offset(7.5)
            make.centerX.equalToSuperview()
        }
        
        //MARK:住宅家具按钮
        residentialFurnitureBtn.snp.makeConstraints { (make) in
            make.width.equalTo(classificationBg).dividedBy(5)
            make.left.equalTo(buildingMaterialsBtn.snp.right)
            make.height.top.equalTo(classificationBg)
        }
        //MARK:住宅家具图片
        residentialFurnitureImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.size.equalTo(38)
        }
        //MARK:住宅家具文本
        residentialFurnitureLabel.snp.makeConstraints { (make) in
            make.top.equalTo(residentialFurnitureImg.snp.bottom).offset(7.5)
            make.centerX.equalToSuperview()
        }

        //MARK:家政安装按钮
        domesticInstallationBtn.snp.makeConstraints { (make) in
            make.width.equalTo(classificationBg).dividedBy(5)
            make.left.equalTo(residentialFurnitureBtn.snp.right)
            make.height.top.equalTo(classificationBg)
        }
        //MARK:家政安装图片
        domesticInstallationImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.size.equalTo(38)
        }
        //MARK:家政安装文本
        domesticInstallationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(domesticInstallationImg.snp.bottom).offset(7.5)
            make.centerX.equalToSuperview()
        }

        //MARK:家用电器按钮
        householdAppliancesBtn.snp.makeConstraints { (make) in
            make.width.equalTo(classificationBg).dividedBy(5)
            make.left.equalTo(domesticInstallationBtn.snp.right)
            make.height.top.equalTo(classificationBg)
        }
        //MARK:家用电器图片
        householdAppliancesImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.size.equalTo(38)
        }
        //MARK:家用电器文本
        householdAppliancesLabel.snp.makeConstraints { (make) in
            make.top.equalTo(householdAppliancesImg.snp.bottom).offset(7.5)
            make.centerX.equalToSuperview()
        }

        //MARK:查看更多按钮
        toViewMoreBtn.snp.makeConstraints { (make) in
            make.width.equalTo(classificationBg).dividedBy(5)
            make.left.equalTo(householdAppliancesBtn.snp.right)
            make.height.top.equalTo(classificationBg)
        }
        //MARK:查看更多图片
        toViewMoreImg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(13)
            make.size.equalTo(38)
        }
        //MARK:查看更多文本
        toViewMoreLabel.snp.makeConstraints { (make) in
            make.top.equalTo(toViewMoreImg.snp.bottom).offset(7.5)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func tapBuildingMaterialsAction(){
        buildingMaterialsAction?()
    }
    @objc func tapResidentialFurnitureAction(){
        residentialFurnitureAction?()
    }
    @objc func tapDomesticInstallationAction(){
        domesticInstallationAction?()
    }
    @objc func tapHouseholdAppliancesAction(){
        householdAppliancesAction?()
    }
    @objc func tapToViewMoreAction(){
        toViewMoreAction?()
    }

}
