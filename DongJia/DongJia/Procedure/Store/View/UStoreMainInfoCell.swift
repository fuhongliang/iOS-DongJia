//
//  UStoreMainInfoCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/8.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UStoreMainInfoCell: UBaseTableViewCell {
    /// 头部的背景颜色图片
    let bgColorImage = UIImageView().then{
        //            $0.image = UIImage.init(named: "default_icon")
        $0.backgroundColor = .green
    }
    /// 白色背景
    let whiteBg = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    /// 店铺主背景图
    let storeBg = UIImageView()
    /// 半透明白色背景(店铺名字)
    let storeInfoBg = UIView().then{
        $0.backgroundColor = .init(r: 255, g: 255, b: 255, a: 0.5)//.hex(hexString: "#4BFFFFFF")
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    /// 店铺头像
    let storeIcon = UIImageView()
    /// 店铺名称
    let storeName = UILabel().then{
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 14)
    }
    /// 综合体验
    let allFeel = UILabel().then{
        $0.text = "综合体验"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 9)
    }
    /// 星星✨
    let starLevel = UIImageView().then{
        $0.image = UIImage.init(named: "yellow_star")
    }
    /// 品牌信息Label
    let brandInfo = UILabel().then{
        $0.text = "南洋胡氏在家居鉴赏家眼中无与伦比的声誉和地位，不仅源于我鉴赏家眼中无与伦比的声誉和地位以及丰富的制艺历史与技术。我们无可争议的领军地位同样来自公司始终秉承 1993年创立以来的卓越制造理来的卓越制造理鉴赏家眼中无与伦比的声誉和地位鉴赏家眼中无与伦比的声誉和地位"
        $0.numberOfLines = 3
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 11)
    }
    let moreInfoBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "down_arrow"), for: .normal)
        $0.setImage(UIImage.init(named: "up_arrow"), for: .selected)
        $0.setTitle("更多品牌信息", for: .normal)
        $0.setTitle("收起品牌信息", for: .selected)
        $0.setTitleColor(.hex(hexString:"#333333"), for: .normal)
        $0.setTitleColor(.hex(hexString:"#333333"), for: .selected)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 11)
    }
    override func configUI() {
        
        contentView.addSubview(bgColorImage)
        contentView.addSubview(whiteBg)
        whiteBg.addSubview(storeBg)
        whiteBg.addSubview(storeInfoBg)
        whiteBg.addSubview(brandInfo)
        whiteBg.addSubview(moreInfoBtn)
        storeInfoBg.addSubview(storeIcon)
        storeInfoBg.addSubview(storeName)
        storeInfoBg.addSubview(allFeel)
        storeInfoBg.addSubview(starLevel)
        
        storeBg.image = UIImage.init(named: "todo_img")
        
        brandInfo.setTextAndLineSpacing(text: "南洋胡氏在家居鉴赏家眼中无与伦比的声誉和地位，不仅源于我鉴赏家眼中无与伦比的声誉和地位以及丰富的制艺历史与技术。我们无可争议的领军地位同样来自公司始终秉承 1993年创立以来的卓越制造理来的卓越制造理鉴赏家眼中无与伦比的声誉和地位鉴赏家眼中无与伦比的声誉和地位", space: 5)
        
        //MARK:背景主颜色
        bgColorImage.snp.makeConstraints { (make) in
            make.top.width.left.equalToSuperview()
            make.height.equalTo(115)
        }
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15)
//            make.height.equalTo(250)
            make.bottom.equalToSuperview()
        }
        //MARK:店铺背景图片
        storeBg.snp.makeConstraints { (make) in
            make.top.left.width.equalToSuperview()
            make.height.equalTo(150)
        }
        //MARK:店铺品牌信息介绍
        brandInfo.snp.makeConstraints { (make) in
            make.top.equalTo(storeBg.snp.bottom).offset(13)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(13)
        }
        //MARK:更多品牌信息
        moreInfoBtn.snp.makeConstraints { (make) in
            make.top.equalTo(brandInfo.snp.bottom).offset(5)
            make.centerX.bottom.equalToSuperview()
            make.height.equalTo(35)
        }
        //MARK:店铺信息背景(名字丶图片)
        storeInfoBg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.bottom.equalTo(storeBg).offset(-20)
            make.size.equalTo(CGSize(width: 160, height: 60))
        }
        //MARK:店铺logo(图标)
        storeIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(35)
            make.left.equalToSuperview().offset(10)
        }
        //MARK:店铺名字
        storeName.snp.makeConstraints { (make) in
            make.left.equalTo(storeIcon.snp.right).offset(7)
            make.top.equalTo(storeIcon)
            make.right.equalToSuperview()
        }
        //MARK:综合体验
        allFeel.snp.makeConstraints { (make) in
            make.bottom.equalTo(storeIcon).offset(-3)
            make.left.equalTo(storeName)
        }
        //MARK:星级
        starLevel.snp.makeConstraints { (make) in
            make.left.equalTo(allFeel.snp.right).offset(8)
            make.size.equalTo(6)
            make.centerY.equalTo(allFeel)
        }
        moreInfoBtn.setButtonShowType(.Left)
    }

}
