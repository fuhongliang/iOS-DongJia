//
//  UShopCartView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

protocol ShopCartDelegate {
    func refreshShopCartList()
    func loadMoreShopCartList()
    func deleteGoods()
    func buy()
    func itemNumberCallBack(section: Int,row: Int, number: Int)
    func selectAll(check: Bool)
    func selectSection(section: Int, check: Bool)
    func selectItem(section: Int,row: Int, check: Bool)
}

class UShopCartView: BaseView {
    
    var delegate: ShopCartDelegate?

    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = UIColor.background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionFooterHeight = .leastNormalMagnitude
        
        $0.register(cellType: UShopCartGoodsCell.self)
    }
    /// 白色背景
    let whiteBg = UIView().then{
        $0.backgroundColor = .white
    }
    /// 全选按钮
    let selectAllBtn = UIButton().then{
        $0.setImage(UIImage.init(named: "select_default_address"), for: .selected)
        $0.setImage(UIImage.init(named: "not_select_default_address"), for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.setTitle("全选", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.backgroundColor = .white
        $0.layoutButton(style: .Left, imageTitleSpace: 10)
    }
    /// 总计
    let allLabel = UILabel().then{
        $0.text = "总计:"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 15)
    }
    /// 价格
    let priceLabel = UILabel().then{
        $0.textColor = .hex(hexString: "#F61616")
        $0.font = .systemFont(ofSize: 15)
    }
    /// 编辑/删除 按钮
    let editOrDelete = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#F7C62F")
        $0.setTitle("编辑", for: .normal)
        $0.setTitle("删除", for: .selected)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    /// 结算/完成 按钮
    let buyOrCompelete = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#0EC262")
        $0.setTitle("结算", for: .normal)
        $0.setTitle("完成", for: .selected)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    override func configUI() {
        // 设置列表的刷新和加载
        tableView.uempty = UEmptyView { [weak self] in self?.refreshShopCart() }
        tableView.uHead = URefreshHeader { [weak self] in self?.refreshShopCart() }

        self.addSubview(tableView)
        self.addSubview(whiteBg)
        whiteBg.addSubview(selectAllBtn)
        whiteBg.addSubview(allLabel)
        whiteBg.addSubview(priceLabel)
        whiteBg.addSubview(editOrDelete)
        whiteBg.addSubview(buyOrCompelete)
        
        selectAllBtn.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        editOrDelete.addTarget(self, action: #selector(editOrDeleteAction), for: .touchUpInside)
        buyOrCompelete.addTarget(self, action: #selector(buyOrCompeleteAction), for: .touchUpInside)

        tableView.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-54)
        }
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.bottom.left.width.equalToSuperview()
            make.height.equalTo(54)
        }
        //MARK:全选按钮
        selectAllBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        //MARK:结算/完成
        buyOrCompelete.snp.makeConstraints { (make) in
            make.height.right.top.equalToSuperview()
            make.width.equalTo(70)
        }
        //MARK:编辑/删除
        editOrDelete.snp.makeConstraints { (make) in
            make.height.top.equalToSuperview()
            make.width.equalTo(70)
            make.right.equalTo(buyOrCompelete.snp.left)
        }
        //MARK:价格
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(editOrDelete.snp.left).offset(-15)
        }
        //MARK:总计
        allLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(priceLabel.snp.left).offset(-10)
        }
    }
    
    func reloadData(){
        tableView.reloadData()
    }
    
    func refreshShopCart(){
        delegate?.refreshShopCartList()
    }
    
    func loadMoreShopCart(){
        delegate?.loadMoreShopCartList()
    }
    
    @objc func selectAllAction(){
        selectAllBtn.isSelected = !selectAllBtn.isSelected
        delegate?.selectAll(check: selectAllBtn.isSelected)
    }
    @objc func editOrDeleteAction(){
        if (editOrDelete.isSelected){
            // 删除
            delegate?.deleteGoods()
        } else {
            // 编辑
            editOrDelete.isSelected = true
            buyOrCompelete.isSelected = true
        }
    }
    @objc func buyOrCompeleteAction(){
        if (buyOrCompelete.isSelected){
            // 完成
            editOrDelete.isSelected = false
            buyOrCompelete.isSelected = false
        } else {
            // 结算
            delegate?.buy()
        }
    }
    /// 设置当前选中的需要支付的价格
    func setPrice(_ price: Double){
        priceLabel.text = "¥\(String(price))"
    }
}
