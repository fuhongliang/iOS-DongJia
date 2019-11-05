//
//  UIConfirmOrderController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit

protocol UIConfirmOrderControllerDelegate {
    func setAddress(address: address_model)
}

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
    
    /// 自营商品 购物车id
    var cart_id_list: [Int]?
    
    /// 地址ID
    var addressId = ""
    
    override func configUI() {
        self.view.addSubview(confirmOrderView)
        confirmOrderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //注册通知--用于接收微信支付的返回的code
        NotificationCenter.default.addObserver(self, selector: #selector(WXPayRequestResult(_:)), name: Notification.Name.weChatPayNotification, object: nil)
        confirmOrderView.delegate = self
        confirmOrderView.tableView.delegate = self
        confirmOrderView.tableView.dataSource = self
        requestSubmitPreviewData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationBar(barStyle: .theme)
    }
    
    /// 请求确认订单的数据
    func requestSubmitPreviewData(){
        service.submitPreView(cart_id_list: cart_id_list ?? [], mch_list: mch_list ?? "", goods_info: goodsInfo ?? "", { (SubmitPreviewData) in
            self.previewData = SubmitPreviewData.data
            self.addressId = SubmitPreviewData.data?.address.id ?? ""
            for _ in self.previewData?.mch_list ?? [] {
                self.messageData.append("")
            }
        }) { (APIErrorModel) in
            
        }
    }
    
    /// 提交订单请求
    /// - Parameters:
    ///     - payment: 0 微信支付
    func submitOrder(payment: Int){
        service.submitOrder(address_id: addressId, cart_id_list: toJson(cart_id_list ?? []), mch_list: mch_list ?? "", payment: payment, { (SubmitOrderData) in
            self.confirmOrderView.postOrder.isEnabled = false
            self.obtainOrderPaySign(orderId: SubmitOrderData.data?.order_id, orderListId: SubmitOrderData.data?.order_id_list)
        }) { (APIErrorModel) in
            
        }
    }
    
    /// 获取订单支付签名 并吊起微信支付页面
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

extension UIConfirmOrderController: UConfirmOrderViewProtocol, UIConfirmOrderControllerDelegate{
    // 选择地址回调
    func setAddress(address: address_model) {
        self.previewData?.address = address
    }
    
    // 提交订单
    func postOrderAction() {
        
        let alert = QMUIAlertController.init(title: "请选择支付方式", message: nil, preferredStyle: .actionSheet)
        let actionWeChat = QMUIAlertAction.init(title: "微信支付", style: .default) { (_, _) in
            showHUDInView(text: "微信支付", inView: self.view, isClick: true)
            self.submitOrder(payment: 0)
        }
        let actionYue = QMUIAlertAction.init(title: "余额支付(暂未开启)", style: .destructive) { (_, _) in
            self.submitOrder(payment: 1)
        }
        actionYue.isEnabled = false
        let action = QMUIAlertAction.init(title: "取消", style: .cancel) { (_, _) in}
        alert.addAction(action)
        alert.addAction(actionWeChat)
        alert.addAction(actionYue)
        alert.showWith(animated: true)
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
            cell.changeReceiptAddress = {
                let vc = UIMyObtainAddressViewController()
                vc.title = "选择收货地址"
                vc.delegate = self
                self.pushViewController(vc, animated: true)
            }
            return cell
        }
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UOrderGoodsInfoCell.self)
        cell.goodsData = self.previewData?.mch_list[indexPath.section-1].list[indexPath.row]
        return cell
    }
    
    
}
