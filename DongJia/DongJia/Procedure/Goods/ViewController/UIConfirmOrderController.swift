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
    
    var previewData: submit_view_model? {
        didSet{
            guard let data = previewData else { return }
            var mchTotalPrice:Double = 0
            var mchExpressPrice:Double = 0
            for item in data.mch_list {
                mchTotalPrice += item.total_price
                mchExpressPrice += item.express_price
                messageData.append("")
            }
            confirmOrderView.allPayPrice = String((data.total_price + mchTotalPrice + mchExpressPrice).roundTo(places: 2))
            confirmOrderView.tableView.reloadData()
        }
    }
    
    /// 保存留言信息
    var messageData = [String]()
    
    /// 商品页直接购买的需要传商品信息
    var goodsInfo: String?
    /// 商品页直接购买 需要传商家ID
    var mchId: Int?
    
    /// 商品页只需要传 商家id Json ----
    /// 购物车需要传 商家id和购物车id数组 Json
    var mch_list: String?
    
    /// 购物车id 如果不传此参数 返回数据会没有data下cart_id_list和list数据
    var cart_id_list: [Int]?
    
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
        service.submitPreView(cart_id_list: toJson(cart_id_list ?? []), mch_list: mch_list ?? "", goods_info: goodsInfo ?? "", { (SubmitPreviewData) in
            self.previewData = SubmitPreviewData.data
            for _ in self.previewData?.mch_list ?? [] {
                self.messageData.append("")
            }
        }) { (APIErrorModel) in
            
        }
    }

}
extension UIConfirmOrderController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = self.previewData?.mch_list.count {
            return count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1
        }
        return self.previewData!.mch_list[section-1].list.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section != 0 {
            let storeHeaderView = UOrderStoreInfoHeaderView()
            storeHeaderView.frame = tableView.bounds
            storeHeaderView.mchData = self.previewData?.mch_list[section-1]
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
            storeFooterView.message = self.messageData[section-1]
            storeFooterView.editMessage = { (message) in
                self.messageData[section-1] = message
            }
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
            cell.addressData = self.previewData?.address
            return cell
        }
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UOrderGoodsInfoCell.self)
        cell.goodsData = self.previewData?.mch_list[indexPath.section-1].list[indexPath.row]
        return cell
    }
    
    
}
