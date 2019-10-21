//
//  UShopCartViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UShopCartViewController: UBaseViewController {
    
    let shopCartView = UShopCartView()
    
    var isCheckAll = false
    
    var allPrice = 0 {
        didSet{
            self.shopCartView.setPrice(allPrice)
        }
    }
    
    var isCheckArray:[[Bool]] = [[Bool]](){
        didSet{
            print("didSet调用了")
            // 遍历每个的值
            for item in isCheckArray{
                for i in item {
                    isCheckAll = i
                    // 如果有一个没选中 就不是全选
                    if !i {
                        shopCartView.selectAllBtn.isSelected = false
                        return
                    }
                }
            }
            // 全选状态
            shopCartView.selectAllBtn.isSelected = true
        }
    }
    
    override func configUI() {
        
        isCheckArray = [[false,false,false],[false,false],[false]]
        
        shopCartView.delegate = self
        shopCartView.tableView.delegate = self
        shopCartView.tableView.dataSource = self
        
        view.addSubview(shopCartView)
        shopCartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension UShopCartViewController: ShopCartDelegate{
    // 删除商品
    func deleteGoods() {
        
    }
    // 结算
    func buy() {
        
    }
    // 商品加减操作
    func itemNumberCallBack(section: Int,row: Int, number: Int){
        showHUDInView(text: "\(number)", inView: self.view, isClick: true)
    }
    // 选择全部
    func selectAll(check: Bool) {
        for (index, item) in isCheckArray.enumerated(){
            for (i,_) in item.enumerated() {
                isCheckArray[index][i] = check
            }
        }
        shopCartView.reloadData()
    }
    // 选择一组
    func selectSection(section: Int, check: Bool) {
        for (index, _) in isCheckArray[section].enumerated() {
            isCheckArray[section][index] = check
        }
        shopCartView.reloadData()
    }
    // 选择一个
    func selectItem(section:Int, row:Int, check: Bool) {
        isCheckArray[section][row] = check
        shopCartView.reloadData()
    }
}

extension UShopCartViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return isCheckArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isCheckArray[section].count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UShopCartHeaderView()
        header.delegate = self
        header.isCheck = true
        for item in isCheckArray[section]{
            if (!item){
                header.isCheck = false
            }
        }
        header.section = section
        header.frame = tableView.bounds
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 59 : 74
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UShopCartGoodsCell.self)
        cell.delegate = self
        cell.isCheck = isCheckArray[indexPath.section][indexPath.row]
        cell.section = indexPath.section
        cell.row = indexPath.row
        return cell
    }
    
    
}
