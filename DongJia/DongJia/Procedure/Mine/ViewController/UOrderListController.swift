//
//  UOrderListController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/11/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation
import JXSegmentedView
import QMUIKit

enum OrderType {
    case All //全部
    case NotPay //待付款
    case NotReceipt //待发货
    case NotObtain //待收货
    case Complete //已完成
    case Sales //售后
    case Cancle //已取消
}

class UOrderListController: UBaseViewController {
    
    private let service = APIOrderService()
    
    /// 当前查看的订单类型
    var orderType: OrderType!
    
    /// 订单列表数据
    var list: [order_list]?{
        didSet{
            tableView.reloadData()
            tableView.uHead.endRefreshing()
            tableView.uFoot.endRefreshing()
        }
    }
    
    var currentPage = 1 // 当前精选的页数
    var pageCount = 0 // 精选的总页数
    /// 当前是否已经是精选列表的最大页数
    var isMaxPage: Bool{
        get {
            return currentPage >= pageCount
        }
    }
    
    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.backgroundColor = UIColor.background
        tw.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tw.separatorStyle = UITableViewCell.SeparatorStyle.none
        tw.showsVerticalScrollIndicator = false
        tw.delegate = self
        tw.dataSource = self
        tw.rowHeight = UITableView.automaticDimension
        tw.uempty = UEmptyView { [weak self] in self?.refreshOrderList() }
        tw.uHead = URefreshHeader{ [weak self] in self?.refreshOrderList() }
        tw.uFoot = URefreshFooter { [weak self] in self?.getOrderList() }
        tw.register(cellType: UOrderListGoodsCell.self)
        return tw
    }()
    
    override func configUI() {
        //注册通知--用于接收微信支付的返回的code
        NotificationCenter.default.addObserver(self, selector: #selector(WXPayRequestResult(_:)), name: Notification.Name.weChatPayNotification, object: nil)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        refreshOrderList()
    }
    
    /// 获取订单列表
    func getOrderList(){
        checkLoginState {
            service.orderList(status: orderType, { (OrderList) in
                
                var orderList = OrderList.data.list
                // 当前已经删除的问题订单的数量
                var removeCount = 0
                for item in 0..<OrderList.data.list.count{
                    if OrderList.data.list[item].goods_list.isEmpty {
                        orderList.remove(at: item - removeCount)
                        removeCount += 1
                    }
                }
                
                self.list = orderList
                
            }) { (APIErrorModel) in
                
            }
        }
    }
    
    /// 刷新当前的订单数据
    func refreshOrderList(){
        getOrderList()
    }
    
    /// 获取订单支付签名 并调起微信支付页面
    /// - Parameters:
    ///     - orderListId: 请求的订单id列表
    func obtainOrderPaySign(orderId: Int? = nil, orderListId: [Int]? = nil){
        service.obtainOrderPaySign(order_id: orderId, order_id_list: orderListId, { (PayData) in
            let payRequest = PayReq()
            payRequest.nonceStr = PayData.data.noncestr
            payRequest.package = PayData.data.package
            payRequest.partnerId = PayData.data.partnerid
            payRequest.prepayId = PayData.data.prepayid
            payRequest.timeStamp = PayData.data.timestamp
            payRequest.sign = PayData.data.sign
            WXApi.send(payRequest)
        }) { (APIErrorModel) in
            
        }
    }
    
    /// 微信支付提示
    @objc func WXPayRequestResult(_ notification: Notification){
        let payResp = notification.object as! PayResp
        switch payResp.errCode{
        case WXSuccess.rawValue:
            showHUDInView(text: "微信支付成功", inView: self.view, isClick: true)
        // 跳转到我的订单页面
        default:
            showHUDInView(text: "微信支付失败", inView: self.view, isClick: true)
            // 跳转到我的订单页面
        }
    }
    
}

extension UOrderListController: UITableViewDelegate, UITableViewDataSource{
    
    ///获取订单类型
    func getOrderDataType(order: order_list) -> OrderType{
        if orderType != OrderType.All{
            return orderType
        } else {
            switch (order.status_code){
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?[section].goods_list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UOrderListHeaderView()
        header.mch = list![section].mch
        header.state = getOrderDataType(order: list![section])
        header.frame = tableView.bounds
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 59
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UOrderListFooterView()
        footer.state = getOrderDataType(order: list![section])
        footer.cancleOrderAction = {
            self.service.cancleOrder(orderId: self.list![section].order_id, { (APIObjectModel) in
                showHUDInView(text: APIObjectModel.msg!, inView: self.view, isClick: true)
                self.refreshOrderList()
            }, { (APIErrorModel) in
                
            })
        }
        footer.deleteOrderAction = {
            showHUDInView(text: "删除订单", inView: self.view, isClick: true)
        }
        footer.confirmObtainAction = {
            showHUDInView(text: "确认收货", inView: self.view, isClick: true)
        }
        footer.contactMchAction = {
            showHUDInView(text: "联系卖家", inView: self.view, isClick: true)
        }
        footer.buyNowAction = {
            let alert = QMUIAlertController.init(title: "请选择支付方式", message: nil, preferredStyle: .actionSheet)
            let actionWeChat = QMUIAlertAction.init(title: "微信支付", style: .default) { (_, _) in
                showHUDInView(text: "微信支付", inView: self.view, isClick: true)
                self.obtainOrderPaySign(orderId: self.list![section].order_id)
            }
            let actionYue = QMUIAlertAction.init(title: "余额支付(暂未开启)", style: .destructive) { (_, _) in
//                self.obtainOrderPaySign()
            }
            actionYue.isEnabled = false
            let action = QMUIAlertAction.init(title: "取消", style: .cancel) { (_, _) in}
            alert.addAction(action)
            alert.addAction(actionWeChat)
            alert.addAction(actionYue)
            alert.showWith(animated: true)
        }
        footer.frame = tableView.bounds
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 59
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UOrderListGoodsCell.self)
        cell.data = list![indexPath.section].goods_list[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UOrderDetailController()
        vc.orderId = list![indexPath.section].order_id
        vc.title = "订单详情"
        pushViewController(vc, animated: true)
    }
    
}

extension UOrderListController: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
}
