//
//  UIConfirmOrderController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIConfirmOrderController: UBaseViewController {
    
    /// 修改状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{ return .lightContent }
    
    let confirmOrderView = UConfirmOrderView()
    override func configUI() {
        self.view.addSubview(confirmOrderView)
        confirmOrderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        confirmOrderView.tableView.delegate = self
        confirmOrderView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationBar(barStyle: .theme)
    }

}
extension UIConfirmOrderController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let storeHeaderView = UOrderStoreInfoHeaderView()
            storeHeaderView.frame = tableView.bounds
            return storeHeaderView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 59
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UConfirmOrderAddressCell.self)
            return cell
        }
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UOrderGoodsInfoCell.self)
        return cell
    }
    
    
}
