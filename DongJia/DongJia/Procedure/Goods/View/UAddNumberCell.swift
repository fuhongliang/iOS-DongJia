//
//  UAddNumberCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/16.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UAddNumberCell: UBaseCollectionViewCell {
    
    /// 购买数量Label
    let buyNumber = UILabel().then{
        $0.text = "购买数量"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 17)
    }
    /// 减－
    let reduceBtn = UIButton().then{
        $0.layer.cornerRadius = 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.hex(hexString: "#CCCCCC").cgColor
        $0.setTitle("－", for: .normal)
        $0.setTitleColor(.hex(hexString: "#CCCCCC"), for: .disabled)
        $0.setTitleColor(.hex(hexString: "#050001"), for: .normal)
        $0.isEnabled = false
        $0.titleLabel?.font = .systemFont(ofSize: 17)
    }
    /// 当前选择的数量
    let number = UILabel().then{
        $0.text = "1"
        $0.textColor = .hex(hexString: "#333333")
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 15)
    }
    /// 加＋
    let addBtn = UIButton().then{
        $0.layer.cornerRadius = 2
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.hex(hexString: "#CCCCCC").cgColor
        $0.setTitle("＋", for: .normal)
        $0.setTitleColor(.hex(hexString: "#CCCCCC"), for: .disabled)
        $0.setTitleColor(.hex(hexString: "#050001"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17)
    }
    
    override func configUI() {
        
        
        contentView.addSubview(buyNumber)
        contentView.addSubview(reduceBtn)
        contentView.addSubview(number)
        contentView.addSubview(addBtn)
        
        //MARK:减
        reduceBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(18)
            make.centerY.equalToSuperview()
        }
        reduceBtn.addTarget(self, action: #selector(reduceAction), for: .touchUpInside)
        //MARK:数量
        number.snp.makeConstraints { (make) in
            make.left.equalTo(reduceBtn.snp.right)
            make.size.equalTo(CGSize(width: 36, height: 18))
            make.centerY.equalTo(reduceBtn)
        }
        //MARK:加
        addBtn.snp.makeConstraints { (make) in
            make.left.equalTo(number.snp.right)
            make.size.equalTo(18)
            make.centerY.equalTo(reduceBtn)
        }
        addBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
    }
    
    @objc func reduceAction(){
        currentNumber -= 1
    }
    
    @objc func addAction(){
        currentNumber += 1
    }
    var currentNumber: Int = 1 {
        didSet{
            number.text = "\(currentNumber)"
            //设置等于1时不能再减
            reduceBtn.isEnabled = currentNumber > 1
            //设置大于99时不能再加
            addBtn.isEnabled = currentNumber < 99
        }
    }
    
    
}
