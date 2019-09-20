//
//  UAboutUsView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UAboutUsView: BaseView {
    
    
    let introduceText = "懂家 以“全面提升中国人的居家文化品质”为宗旨，总部位于上海，现已成为大型家居卖场连锁集团、国内家居行业的领军企业，将Shopping Mall业态和家居关联商品引入家居商场，满足了一站式消费需求。在二十多年积累沉淀的基础上，2010年3月正式启动“百店计划”。为了提升家居卖场的文化品格、购物环境和服务档次，月星家居师法英国百年老店哈罗德百货公司（Harrods），启动打造“中国家居业的哈罗德”的改造升级工程，旨在将月星家居广场从平台式卖场升级为家居主题购物中心"
    let logo = UIImageView().then{
        $0.image = UIImage.init(named: "logo")
    }
    let appName = UILabel().then{
        $0.text = "懂家"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 18)
    }
    let appVersionLabel = UILabel().then{
        $0.text = "V\(appVersion)"
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .hex(hexString: "#999999")
    }
    let appIntroduction = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
    }
    
    override func configUI() {
        let scrollView = UIScrollView(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)).then{
            $0.showsVerticalScrollIndicator = false //是否显示滚动条
            $0.backgroundColor = .white
            $0.bounces = true //设置是否可以拉出空白区域
            $0.isScrollEnabled = true //设置允许滑动
        }
        self.addSubview(scrollView)
        scrollView.addSubview(logo)
        scrollView.addSubview(appName)
        scrollView.addSubview(appVersionLabel)
        appIntroduction.setTextAndLineSpacing(text: introduceText, space: 10)
        scrollView.addSubview(appIntroduction)
        
        //MARK:logo
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.size.equalTo(125)
        }
        //MARK:APP名称
        appName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(logo.snp.bottom).offset(15.5)
        }
        //MARK:版本号
        appVersionLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(appName.snp.bottom).offset(14)
        }
        //MARK:懂家介绍
        appIntroduction.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.top.equalTo(appVersionLabel.snp.bottom).offset(45)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
    }
    
}
