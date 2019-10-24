//
//  UIConfirmOrderController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIConfirmOrderController: UBaseViewController {
    
    /// 修改状态栏文字颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{ return .lightContent }
    
    private let service = APIOrderService()
    
    private let confirmOrderView = UConfirmOrderView()
    
    /// 商品页直接购买的需要传商品信息
    var goodsInfo: String?
    
    override func configUI() {
        self.view.addSubview(confirmOrderView)
        confirmOrderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        confirmOrderView.tableView.delegate = self
        confirmOrderView.tableView.dataSource = self
        
        requestSubmitPreviewData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationBar(barStyle: .theme)
    }
    
    /// 请求确认订单的数据
    func requestSubmitPreviewData(){
        service.submitPreView(cart_id_list: "", mch_list: "", goods_info: goodsInfo ?? "", { (SubmitPreviewData) in
            print("\(SubmitPreviewData.msg ?? "----////----")")
        }) { (APIErrorModel) in
            
        }
    }

}
extension UIConfirmOrderController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1
        }
        return 3
    }
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
        if section != 0 {
            let storeFooterView = UOrderStoreInfoFooterView()
            storeFooterView.frame = tableView.bounds
            return storeFooterView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 59
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
