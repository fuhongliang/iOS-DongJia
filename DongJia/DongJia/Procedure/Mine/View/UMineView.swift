//
//  UMineView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/19.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

protocol UMineViewDelegate {
    /// 我的订单
    func myAllOrder()
    /// 微信登录
    func wechatLogin()
    /// 退出登录
    func logout()
    /// 待付款订单
    func notPayOrder()
    /// 待发货订单
    func notSendOrder()
    /// 待收货订单
    func notObtainOrder()
    /// 已完成订单
    func completeOrder()
    /// 我的售后
    func myAfterSales()
    /// 我的收藏
    func myCollection()
    /// 收货地址
    func obtainAddress()
    /// 关于我们
    func aboutOus()
}

class UMineView: BaseView {

    var delegate: UMineViewDelegate?
    
    /// 个人中心-头部
    let mineLabel = UILabel().then{
        $0.text = "个人中心"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
//        $0.font = .boldSystemFont(ofSize: 18)
    }
    /// 绿色的背景
    let themeBg = UIView().then{
        $0.backgroundColor = .hex(hexString: "#0EC262")
    }
    /// 个人信息的白色背景
    let mineWhiteBg = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    /// 头像icon
    let mineIcon = UIImageView().then{
        $0.layer.cornerRadius = 38
        $0.layer.masksToBounds = true
        $0.image = UIImage.init(named: "default_icon")
    }
    /// 用户名称
    let mineName = UILabel().then{
        $0.text = "Hi~欢迎来到懂家"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 18)
    }
    /// 已登录的操作View
    let haveLoginView = UIView().then{
        $0.backgroundColor = .white
    }
    /// 我的订单按钮
    let mineOrderBtn = UIButton().then{
        $0.backgroundColor = .white
    }
    /// 我的订单Label
    let mineOrderLabel = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.text = "我的订单"
        $0.font = .systemFont(ofSize: 13)
    }
    /// 查看全部订单Label
    let viewAllOrderLabel = UILabel().then{
        $0.textColor = .hex(hexString: "#999999")
        $0.text = "查看全部订单"
        $0.font = .systemFont(ofSize: 12)
    }
    /// 右箭头→
    let rightArrow = UIImageView().then{
        $0.image = UIImage.init(named: "right_arrow")
    }
    /// 我的订单按钮下的线🧵
    let myOrderLine = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#F2F2F2")
    }
    /// 待付款
    let notPayOrder = UIButton().then{
        $0.setTitle("待付款", for: .normal)
        $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "not_pay_order"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    /// 待发货
    let notSendOrder = UIButton().then{
        $0.setTitle("待发货", for: .normal)
        $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "not_send_order"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    /// 待收货
    let notObtainOrder = UIButton().then{
        $0.setTitle("待收货", for: .normal)
        $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "not_obtain_order"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    /// 已完成
    let completeOrder = UIButton().then{
        $0.setTitle("待收货", for: .normal)
        $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "complete_order"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    /// 未登录的操作背景
    let logoutBgView = UIView().then{
        $0.backgroundColor = .white
    }
    /// 登录后获取更多精彩内容
    let tipLoginLabel = UILabel().then{
        $0.text = "登录后获取更多精彩内容"
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 11)
    }
    /// 微信登录按钮
    let wechatLoginBtn = UIButton().then{
        $0.setTitle("微信登录", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 22
        $0.layer.masksToBounds = true
        $0.backgroundColor = .hex(hexString: "#0EC262")
    }
    
    /// 一些操作的背景
    let operationWhiteBg = UIView().then{
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    /// 我的售后
    let myAfterSales = UIButton().then{
        $0.setTitle("我的售后", for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "after_sales"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .left
        $0.layoutButton(style: .Left, imageTitleSpace: 12.5, styleSpace: 26)
    }
    /// 我的售后🧵
    let myAfterSalesLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    /// 我的收藏
    let myCollection = UIButton().then{
        $0.setTitle("我的收藏", for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "collection"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .left
        $0.layoutButton(style: .Left, imageTitleSpace: 12.5, styleSpace: 26)
    }
    /// 我的收藏🧵
    let myCollectionLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    /// 收货地址
    let myObtainAddress = UIButton().then{
        $0.setTitle("收货地址", for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "obtain_address"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .left
        $0.layoutButton(style: .Left, imageTitleSpace: 12.5, styleSpace: 26)
    }
    /// 收货地址🧵
    let myObtainAddressLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    /// 关于我们
    let aboutOus = UIButton().then{
        $0.setTitle("关于我们", for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "about_ous"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .left
        $0.layoutButton(style: .Left, imageTitleSpace: 12.5, styleSpace: 26)
    }
    /// 关于我们🧵
    let aboutOusLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    /// 退出登录
    let logout = UIButton().then{
        $0.setTitle("退出登录", for: .normal)
        $0.setTitleColor(.hex(hexString:"#F51616"), for: .normal)
        $0.layer.cornerRadius = 22
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.hex(hexString: "#F51616").cgColor
        $0.titleLabel?.font = .systemFont(ofSize: 16)
    }
    
    override func configUI() {
        
        self.addSubview(themeBg)
        self.addSubview(mineLabel)
        self.addSubview(mineWhiteBg)
        self.addSubview(mineIcon)
        
        mineWhiteBg.addSubview(mineName)
        
        mineWhiteBg.addSubview(haveLoginView)
        haveLoginView.addSubview(mineOrderBtn)
        mineOrderBtn.addTarget(self, action: #selector(tapMyAllOrder), for: .touchUpInside)
        haveLoginView.addSubview(mineOrderLabel)
        haveLoginView.addSubview(viewAllOrderLabel)
        haveLoginView.addSubview(rightArrow)
        haveLoginView.addSubview(myOrderLine)
        haveLoginView.addSubview(notPayOrder)
        haveLoginView.addSubview(notSendOrder)
        haveLoginView.addSubview(notObtainOrder)
        haveLoginView.addSubview(completeOrder)
        
        mineWhiteBg.addSubview(logoutBgView)
        logoutBgView.addSubview(tipLoginLabel)
        logoutBgView.addSubview(wechatLoginBtn)
        wechatLoginBtn.addTarget(self, action: #selector(tapWechatLogin), for: .touchUpInside)
        
        self.addSubview(operationWhiteBg)
        operationWhiteBg.addSubview(myAfterSales)
        operationWhiteBg.addSubview(myCollection)
        operationWhiteBg.addSubview(myObtainAddress)
        operationWhiteBg.addSubview(aboutOus)
        operationWhiteBg.addSubview(myAfterSalesLine)
        operationWhiteBg.addSubview(myCollectionLine)
        operationWhiteBg.addSubview(myObtainAddressLine)
        
        
        //MARK:绿色背景
        themeBg.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(177.5 + statusbarHeight)
        }
        //MARK:个人中心
        mineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(statusbarHeight)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:个人信息的白色背景
        mineWhiteBg.snp.makeConstraints { (make) in
            make.top.equalTo(mineLabel.snp.bottom).offset(49)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(175)
            make.centerX.equalToSuperview()
        }
        //MARK:头像
        mineIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(mineWhiteBg.snp.top)
            make.centerX.equalToSuperview()
            make.size.equalTo(76)
        }
        //MARK:名称
        mineName.snp.makeConstraints { (make) in
            make.top.equalTo(mineIcon.snp.bottom).offset(11)
            make.centerX.equalToSuperview()
        }
        //MARK:登录后的背景
        haveLoginView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.left.equalToSuperview()
            make.top.equalTo(mineName.snp.bottom)
        }
        //MARK:我的订单按钮
        mineOrderBtn.snp.makeConstraints { (make) in
            make.width.top.equalToSuperview()
            make.height.equalTo(40)
        }
        //MARK:我的订单Label
        mineOrderLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(11)
            make.centerY.equalTo(mineOrderBtn)
        }
        //MARK:右箭头
        rightArrow.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-11)
            make.centerY.equalTo(mineOrderBtn)
        }
        //MARK:查看全部订单
        viewAllOrderLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightArrow.snp.left).offset(-6)
            make.centerY.equalTo(mineOrderBtn)
        }
        //MARK:我的订单下面的🧵
        myOrderLine.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(mineOrderBtn.snp.bottom)
            make.height.equalTo(0.5)
        }
        //MARK:待付款
        notPayOrder.snp.makeConstraints { (make) in
            make.top.equalTo(myOrderLine.snp.bottom)
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().dividedBy(4)
        }
        //MARK:待发货
        notSendOrder.snp.makeConstraints { (make) in
            make.top.equalTo(myOrderLine.snp.bottom)
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
            make.left.equalTo(notPayOrder.snp.right)
            make.width.equalToSuperview().dividedBy(4)
        }
        //MARK:待收货
        notObtainOrder.snp.makeConstraints { (make) in
            make.top.equalTo(myOrderLine.snp.bottom)
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
            make.left.equalTo(notSendOrder.snp.right)
            make.width.equalToSuperview().dividedBy(4)
        }
        //MARK:已完成
        completeOrder.snp.makeConstraints { (make) in
            make.top.equalTo(myOrderLine.snp.bottom)
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
            make.left.equalTo(notObtainOrder.snp.right)
            make.width.equalToSuperview().dividedBy(4)
        }
        notPayOrder.setImgUpTitleDown()
        notSendOrder.setImgUpTitleDown()
        notObtainOrder.setImgUpTitleDown()
        completeOrder.setImgUpTitleDown()
        
        //MARK:未登录的背景
        logoutBgView.isHidden = true
        logoutBgView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.left.equalToSuperview()
            make.top.equalTo(mineName.snp.bottom)
        }
        //MARK:未登录提示
        tipLoginLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        //MARK:微信登录按钮
        wechatLoginBtn.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(65)
            make.centerX.equalToSuperview()
            make.top.equalTo(tipLoginLabel.snp.bottom).offset(22)
            make.height.equalTo(44)
        }
        
        //MARK:菜单的背景
        operationWhiteBg.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(mineWhiteBg.snp.bottom).offset(15)
            make.height.equalTo(44 * 4)
        }
        //MARK:我的售后
        myAfterSales.snp.makeConstraints { (make) in
            make.width.top.left.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:我的售后🧵
        myAfterSalesLine.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(myAfterSales.snp.bottom)
        }
        //MARK:我的收藏
        myCollection.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(myAfterSales.snp.bottom)
        }
        //MARK:我的收藏🧵
        myCollectionLine.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(myCollection.snp.bottom)
        }
        //MARK:收货地址
        myObtainAddress.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(myCollection.snp.bottom)
        }
        //MARK:收货地址🧵
        myObtainAddressLine.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(myObtainAddress.snp.bottom)
        }
        //MARK:关于我们
        aboutOus.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(myObtainAddress.snp.bottom)
        }
        
        self.addSubview(logout)
        //MARK:退出登录
        logout.snp.makeConstraints { (make) in
            make.top.equalTo(operationWhiteBg.snp.bottom).offset(40)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        logout.addTarget(self, action: #selector(tapLogout), for: .touchUpInside)
        
    }
    
    @objc func tapMyAllOrder(){
        showHUDInView(text: "我的全部订单", inView: self)
        delegate?.myAllOrder()
    }
    
    @objc func tapNotPayOrder(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.notPayOrder()
    }
    
    @objc func tapNotSendOrder(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.notSendOrder()
    }
    
    @objc func tapNotObtainOrder(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.notObtainOrder()
    }
    
    @objc func tapCompleteOrder(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.completeOrder()
    }
    
    @objc func tapMyAfterSales(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.myAfterSales()
    }
    
    @objc func tapMyCollection(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.myCollection()
    }
    
    @objc func tapObtainAddress(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.obtainAddress()
    }
    
    @objc func tapAboutOus(){
        showHUDInView(text: "待发货订单", inView: self)
        delegate?.aboutOus()
    }
    
    @objc func tapWechatLogin(){
        haveLoginView.isHidden = false
        logoutBgView.isHidden = true
        mineName.text = "Muzi_Lm"
        logout.isHidden = false
        delegate?.wechatLogin()
    }
    
    @objc func tapLogout(){
        haveLoginView.isHidden = true
        logoutBgView.isHidden = false
        logout.isHidden = true
        mineName.text = "Hi~欢迎来到懂家"
        delegate?.logout()
    }

}
