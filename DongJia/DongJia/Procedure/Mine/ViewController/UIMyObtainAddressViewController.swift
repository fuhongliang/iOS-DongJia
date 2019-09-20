//
//  UIMyObtainAddressViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIMyObtainAddressViewController: UBaseViewController {
    
    let obtainAddressView = UMyObtainAddressView()
    var data:[[String:String]] = [["name":"符宏梁","phone":"13265345992","address":"广东省深圳市宝安区新安街道新安三路28号","is_default":"1"],
                                  ["name":"于亿鑫","phone":"13265345992","address":"广东省深圳市宝安区新安街道新安三路28号","is_default":"0"],
                                  ["name":"詹庆谭","phone":"13265345992","address":"广东省深圳市宝安区新安街道新安三路28号","is_default":"0"],
                                  ["name":"刘燕家","phone":"13265345992","address":"广东省深圳市宝安区新安街道新安三路28号","is_default":"0"],
                                  ["name":"朱伟超","phone":"13265345992","address":"广东省深圳市宝安区新安街道新安三路28号","is_default":"0"]]
    
    override func configUI() {
        
        self.view.addSubview(obtainAddressView)
        obtainAddressView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        obtainAddressView.delegate = self
        obtainAddressView.tableView.delegate = self
        obtainAddressView.tableView.dataSource = self
    }

}
extension UIMyObtainAddressViewController: UMyObtainAddressViewDelegate,UITableViewDelegate, UITableViewDataSource {
    
    func addAddress() {
        showHUDInView(text: "添加新地址", inView: self.view)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UObtainAddressCell.self)
        cell.setDefaultAddress = {
            for (index,_) in self.data.enumerated() {
                self.data[index]["is_default"] = index == indexPath.section ? "1" : "0"
            }
            tableView.reloadData()
        }
        cell.editAddress = {
            showHUDInView(text: "编辑", inView: self.view)
        }
        cell.deleteAddress = {
            showHUDInView(text: "删除", inView: self.view)
        }
        cell.model = data[indexPath.section]
        return cell
    }
    
}
