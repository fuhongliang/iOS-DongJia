//
//  UOrderDetailController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/13.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UOrderDetailController: UBaseViewController {
    
    var orderId: Int!
    
    var orderDetail: order_detail_model?{
        didSet{
            guard orderDetail != nil else { return }
            tableView.reloadData()
        }
    }
    
    private let service = APIOrderService()
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tw.separatorStyle = UITableViewCell.SeparatorStyle.none
        tw.showsVerticalScrollIndicator = false
        tw.delegate = self
        tw.dataSource = self
        tw.rowHeight = UITableView.automaticDimension
        tw.register(cellType: UPayInfoCell.self)
        tw.register(cellType: UOrderInfoCell.self)
        tw.register(cellType: UOrderNotPayOrCancleCell.self)
        tw.register(cellType: UOrderListGoodsCell.self)
        return tw
    }()
    
    override func configUI() {
        tableView.backgroundColor = .background
        view.backgroundColor = .background
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
        }
        getOrderDetail()
    }
    
    func getOrderDetail(){
        service.orderDetail(orderId: orderId, { (OrderDetail) in
            self.orderDetail = OrderDetail.data
        }) { (APIErrorModel) in
            
        }
    }
    
    func getOrderTypeForStatusCode(statusCode: Int) -> OrderType{
        ///获取订单类型
        switch (statusCode){
        case 0:
            return .NotPay
        case 1:
            return .NotReceipt
        case 2:
            return .NotObtain
        case 3:
            return .Complete
        case 4:
            return .Sales
        case 5:
            return .Cancle
        default:
            return .All
        }
    }
    
}

extension UOrderDetailController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return orderDetail?.goods_list.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (section == 0) {
            switch getOrderTypeForStatusCode(statusCode: orderDetail?.status_code ?? -1) {
            case .NotReceipt,.NotObtain,.Complete:
                let headerView = UOrderDetailSendObtainHeader()
                headerView.data = orderDetail
                headerView.goToMch = {
                    let vc = UIStoreController()
                    vc.title = "商家主页"
                    vc.storeId = "\(self.orderDetail!.mch.id)"
                    self.pushViewController(vc, animated: true)
                }
                headerView.frame = tableView.bounds
                return headerView
            case .Cancle,.NotPay:
                let headerView = UOrderDetailNotPayOrCancleHeader()
                headerView.data = orderDetail
                headerView.goToMch = {
                    let vc = UIStoreController()
                    vc.title = "商家主页"
                    vc.storeId = "\(self.orderDetail!.mch.id)"
                    self.pushViewController(vc, animated: true)
                }
                headerView.frame = tableView.bounds
                return headerView
            default:
                return nil
            }
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 0
        }
        switch getOrderTypeForStatusCode(statusCode: orderDetail?.status_code ?? -1) {
        case .NotReceipt,.NotObtain,.Complete:
            return 241
        case .Cancle,.NotPay:
            return 180
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UOrderListGoodsCell.self)
            cell.orderDetailData = orderDetail?.goods_list[indexPath.row]
            
            return cell
        } else if (indexPath.section == 1){
            switch getOrderTypeForStatusCode(statusCode: orderDetail?.status_code ?? -1){
            case .NotReceipt,.NotObtain,.Complete,.All,.Sales:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UPayInfoCell.self)
                cell.data = orderDetail
                return cell
            case .Cancle,.NotPay:
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UOrderNotPayOrCancleCell.self)
                cell.data = orderDetail
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UOrderInfoCell.self)
            cell.data = orderDetail
            cell.copyAction = {
                UIPasteboard.general.string = self.orderDetail?.order_no
                showHUDInView(text: "复制成功", inView: self.view, isClick: true)
            }
            return cell
        }
    }
    
    
    
    
}
