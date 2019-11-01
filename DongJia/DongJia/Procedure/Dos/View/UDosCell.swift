//
//  UDosCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

var dosCellHeight = (screenWidth-30)/2.3 + 67

class UDosCell: UBaseTableViewCell {
    /// 白色背景板
    let whiteBg = UIView().then{
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.white
    }
    /// 家装方案的图片
    let dosImg = UIImageView()
    /// 家装方案标题
    let dosTitle = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.numberOfLines = 1
    }
    /// 作者头像
    let authorIcon = UIImageView().then{
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    /// 作者名称
    let authorName = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.hex(hexString: "#999999")
    }
    /// 竖直线
    let verticalLine = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#999999")
    }
    /// 发布时间
    let releaseTime = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = UIColor.hex(hexString: "#999999")
    }
    
    override func configUI() {
        
        contentView.backgroundColor = .background
        contentView.addSubview(whiteBg)
        whiteBg.addSubview(dosImg)
        whiteBg.addSubview(dosTitle)
        whiteBg.addSubview(authorIcon)
        whiteBg.addSubview(authorName)
        whiteBg.addSubview(verticalLine)
        whiteBg.addSubview(releaseTime)
        
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.height.equalTo(dosCellHeight)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        
        //MARK:家装方案主图片
        dosImg.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(dosCellHeight-67)
        }
        
        //MARK:家装方案标题
        dosTitle.snp.makeConstraints { (make) in
            make.top.equalTo(dosImg.snp.bottom).offset(10)
            make.left.right.equalTo(dosImg).inset(11)
        }
        
        //MARK:作者头像
        authorIcon.snp.makeConstraints { (make) in
            make.size.equalTo(20)
            make.left.equalTo(dosTitle)
            make.top.equalTo(dosTitle.snp.bottom).offset(11)
        }
        
        //MARK:作者名称
        authorName.snp.makeConstraints { (make) in
            make.left.equalTo(authorIcon.snp.right).offset(7.5)
            make.centerY.equalTo(authorIcon)
        }
        
        //MARK:竖直分割线
        verticalLine.snp.makeConstraints { (make) in
            make.left.equalTo(authorName.snp.right).offset(8)
            make.centerY.equalTo(authorIcon)
            make.width.equalTo(1)
            make.height.equalTo(authorIcon).inset(2)
        }
        
        //MARK:发布时间
        releaseTime.snp.makeConstraints { (make) in
            make.left.equalTo(verticalLine.snp.right).offset(8)
            make.centerY.equalTo(authorIcon)
        }
        
    }
    
    var model: dos_model? {
        didSet{
            guard let model = model else { return }
            
            dosImg.load(model.cover_pic)
            dosTitle.text = model.title
            authorIcon.load(model.author_logo)
            authorName.text = model.author
            releaseTime.text = model.addtime
            
            
        }
    }
    
}
