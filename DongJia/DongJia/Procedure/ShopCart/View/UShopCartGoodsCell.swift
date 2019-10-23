//
//  UShopCartGoodsCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/21.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UShopCartGoodsCell: UBaseTableViewCell {
    
    var delegate: ShopCartDelegate?
    
    var section:Int = 0
    var row:Int = 0
    
    /// 选择按钮
    let selectBtn = UIButton().then{
        $0.setImage(UIImage.init(named: "select_default_address"), for: .selected)
        $0.setImage(UIImage.init(named: "not_select_default_address"), for: .normal)
    }
    /// 商品图片
    let goodsPic = UIImageView().then{
        $0.backgroundColor = .random
    }
    /// 商品名称
    let goodsName = UILabel().then{
        $0.text = "iPhone手机📱"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 15)
    }
    /// 选择的商品属性
    let goodsAttrLabel = UILabel().then{
        $0.text = "最新 顶配"
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 13)
        $0.numberOfLines = 2
    }
    /// 该商品单价
    let goodsPrice = UILabel().then{
        $0.text = "¥10"
        $0.textColor = .hex(hexString: "#F61616")
        $0.font = .systemFont(ofSize: 16)
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
        
        contentView.addSubview(selectBtn)
        contentView.addSubview(goodsPic)
        contentView.addSubview(goodsName)
        contentView.addSubview(goodsAttrLabel)
        contentView.addSubview(goodsPrice)
        contentView.addSubview(reduceBtn)
        contentView.addSubview(number)
        contentView.addSubview(addBtn)
        
        selectBtn.addTarget(self, action: #selector(selectItem), for: .touchUpInside)
        addBtn.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        reduceBtn.addTarget(self, action: #selector(reduceAction), for: .touchUpInside)
        
        //MARK:选择按钮
        selectBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview()//.offset(31.5)
            make.height.equalTo(80)
            make.width.equalTo(46)
            make.left.equalToSuperview()//.offset(15)
        }
        //MARK:商品图片
        goodsPic.snp.makeConstraints { (make) in
            make.size.equalTo(80)
            make.top.equalToSuperview()
            make.left.equalTo(selectBtn.snp.right)
            make.bottom.equalToSuperview().offset(-15)
        }
        //MARK:商品名称
        goodsName.snp.makeConstraints { (make) in
            make.left.equalTo(goodsPic.snp.right).offset(14)
            make.top.equalTo(goodsPic)
            make.right.equalToSuperview().offset(-5)
        }
        //MARK:商品属性
        goodsAttrLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(goodsName)
            make.top.equalTo(goodsName.snp.bottom)
        }
        //MARK:商品价格
        goodsPrice.snp.makeConstraints { (make) in
            make.left.equalTo(goodsName)
            make.bottom.equalTo(goodsPic)
        }
        //MARK:加
        addBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(goodsPic)
            make.size.equalTo(18)
        }
        //MARK:当前的数量
        number.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(addBtn)
            make.right.equalTo(addBtn.snp.left)
            make.width.equalTo(25)
        }
        //MARK:减
        reduceBtn.snp.makeConstraints { (make) in
            make.size.equalTo(18)
            make.right.equalTo(number.snp.left)
            make.bottom.equalTo(goodsPic)
        }
    }
    
    @objc func selectItem(){
        selectBtn.isSelected = !selectBtn.isSelected
        delegate?.selectItem(section:section,row:row, check: selectBtn.isSelected)
    }
    
    /// 选中状态
    var isCheck: Bool = false {
        didSet{
            self.selectBtn.isSelected = isCheck
        }
    }
    
    /// 设置数据
    var data: [String:String]? {
        didSet{
            guard let data = data else { return }
            goodsPic.load(data["picUrl"])
            goodsName.text = data["goodsName"]
            goodsAttrLabel.text = data["attr"]
            goodsPrice.text = "¥\(data["price"] ?? "-")"
        }
    }
    
    @objc func reduceAction(){
        currentNumber -= 1
        delegate?.itemNumberCallBack(section: section, row: row, number: currentNumber)
    }
    
    @objc func addAction(){
        currentNumber += 1
        delegate?.itemNumberCallBack(section: section, row: row, number: currentNumber)
    }
    
    var maxNumber: Int = 1
    
    var currentNumber: Int = 1 {
        didSet{
            number.text = "\(currentNumber)"
            //设置等于1时不能再减
            reduceBtn.isEnabled = currentNumber > 1
            //设置大于99时不能再加
            addBtn.isEnabled = currentNumber < maxNumber
        }
    }

}
