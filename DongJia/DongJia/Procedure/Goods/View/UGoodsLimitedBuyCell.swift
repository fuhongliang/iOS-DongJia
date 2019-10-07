//
//  UGoodsLimitedBuyCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/27.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

/// (商品详情)限时抢购的cell
class UGoodsLimitedBuyCell: UBaseTableViewCell {
    
    /// 右边黄色背景
    let yellowBg = UIView().then{
        $0.backgroundColor = .hex(hexString: "#FFD657")
        
    }
    /// 左边绿色背景
    let greenBg = UIView().then{
        $0.backgroundColor = .hex(hexString: "#0EC262")
    }
    /// ¥符号
    let rmbSign = UILabel().then{
        $0.text = "¥"
        $0.font = .boldSystemFont(ofSize: 12)
        $0.textColor = .white
    }
    /// 当前限时价格
    let rmbLabel = UILabel().then{
        $0.text = "3398"
        $0.font = .boldSystemFont(ofSize: 21)
        $0.textColor = .white
    }
    /// 原价
    let originalPrice = UILabel().then{
        $0.text = "¥4398"
        $0.font = .systemFont(ofSize: 9)
        $0.textColor = .white
    }
    /// 购买人数
    let buyPeopleNumber = UILabel().then{
        $0.text = "33人已买"
        $0.font = .systemFont(ofSize: 9)
        $0.textColor = .white
    }
    /// "距离结束仅剩"
    let overTimeTip = UILabel().then{
        $0.textColor = .hex(hexString: "#242117")
        $0.text = "距离结束仅剩"
        $0.font = .systemFont(ofSize: 9)
        $0.textAlignment = .right
    }
    /// (倒计时)天
    let day = UILabel().then{
        $0.text = "10"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 9)
        $0.backgroundColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
    }
    /// (倒计时)冒号1
    let split1 = UILabel().then{
        $0.text = ":"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 9)
        $0.textAlignment = .center
    }
    /// (倒计时)小时
    let hour = UILabel().then{
        $0.text = "21"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 9)
        $0.backgroundColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
    }
    /// (倒计时)冒号2
    let split2 = UILabel().then{
        $0.text = ":"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 9)
        $0.textAlignment = .center
    }
    /// (倒计时)分钟
    let minite = UILabel().then{
        $0.text = "59"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 9)
        $0.backgroundColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
    }
    /// (倒计时)冒号3
    let split3 = UILabel().then{
        $0.text = ":"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 9)
        $0.textAlignment = .center
    }
    /// (倒计时)秒
    let second = UILabel().then{
        $0.text = "41"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 9)
        $0.backgroundColor = .black
        $0.textAlignment = .center
        $0.layer.cornerRadius = 1
        $0.layer.masksToBounds = true
    }

    override func configUI() {
        contentView.addSubview(greenBg)
        contentView.addSubview(yellowBg)
        greenBg.addSubview(rmbSign)
        greenBg.addSubview(rmbLabel)
        greenBg.addSubview(originalPrice)
        greenBg.addSubview(buyPeopleNumber)
        yellowBg.addSubview(overTimeTip)
        yellowBg.addSubview(day)
        yellowBg.addSubview(split1)
        yellowBg.addSubview(hour)
        yellowBg.addSubview(split2)
        yellowBg.addSubview(minite)
        yellowBg.addSubview(split3)
        yellowBg.addSubview(second)
        
        //MARK:绿色背景
        greenBg.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth-125)
            make.top.left.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        //MARK:黄色背景
        yellowBg.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(125)
            make.height.equalTo(40)
        }
        //MARK:当前的价格
        rmbLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25)
        }
        //MARK:人民币¥
        rmbSign.snp.makeConstraints { (make) in
            make.right.equalTo(rmbLabel.snp.left).offset(-1)
            make.bottom.equalTo(rmbLabel).offset(-2)
        }
        //MARK:原价
        originalPrice.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(9)
            make.left.equalTo(rmbLabel.snp.right).offset(11)
        }
        //MARK:已经购买人数
        buyPeopleNumber.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-9)
            make.left.equalTo(rmbLabel.snp.right).offset(11)
        }
        
        //MARK:结束提示
        overTimeTip.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.right.equalToSuperview().offset(-14)
        }
        //MARK:倒计时 秒
        second.snp.makeConstraints { (make) in
            make.size.equalTo(13)
            make.right.equalTo(overTimeTip)
            make.bottom.equalToSuperview().offset(-6.5)
        }
        //MARK:冒号
        split3.snp.makeConstraints { (make) in
            make.size.equalTo(9.5)
            make.right.equalTo(second.snp.left)
            make.centerY.equalTo(second)
        }
        //MARK:倒计时 分
        minite.snp.makeConstraints { (make) in
            make.size.equalTo(13)
            make.right.equalTo(split3.snp.left)
            make.bottom.equalToSuperview().offset(-6.5)
        }
        //MARK:冒号
        split2.snp.makeConstraints { (make) in
            make.size.equalTo(9.5)
            make.right.equalTo(minite.snp.left)
            make.centerY.equalTo(second)
        }
        //MARK:倒计时 小时
        hour.snp.makeConstraints { (make) in
            make.size.equalTo(13)
            make.right.equalTo(split2.snp.left)
            make.bottom.equalToSuperview().offset(-6.5)
        }
        //MARK:冒号
        split1.snp.makeConstraints { (make) in
            make.size.equalTo(9.5)
            make.right.equalTo(hour.snp.left)
            make.centerY.equalTo(second)
        }
        //MARK:倒计时 天
        day.snp.makeConstraints { (make) in
            make.size.equalTo(13)
            make.right.equalTo(split1.snp.left)
            make.bottom.equalToSuperview().offset(-6.5)
        }
    }
    
}
