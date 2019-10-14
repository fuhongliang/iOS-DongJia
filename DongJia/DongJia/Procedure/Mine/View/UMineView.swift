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
    /// 我的优惠券
    func myCoupon()
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
    
    let scroll = UIScrollView().then{
        $0.showsVerticalScrollIndicator = false //是否显示滚动条
        $0.backgroundColor = .background
        $0.bounces = true //设置是否可以拉出空白区域
        $0.isScrollEnabled = true //设置允许滑动
    }
    
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
    /// 我的积分背景按钮
    let integralBtn = UIButton().then{
        $0.backgroundColor = .white
    }
    /// 积分
    let integral = UILabel().then{
        $0.text = "998"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 19)
    }
    /// 我的积分Label
    let myIntegral = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.text = "我的积分"
        $0.font = .systemFont(ofSize: 12)
    }
    /// 我的余额背景按钮
    let balanceBtn = UIButton().then{
        $0.backgroundColor = .white
    }
    /// 余额
    let balance = UILabel().then{
        $0.text = "10万"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 19)
    }
    /// 我的余额Label
    let myBalance = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.text = "我的余额"
        $0.font = .systemFont(ofSize: 12)
    }
    /// 我的家居贷背景按钮
    let loanBtn = UIButton().then{
        $0.backgroundColor = .white
    }
    /// 家居贷
    let loan = UILabel().then{
        $0.text = "1块"
        $0.textColor = .black
        $0.font = .boldSystemFont(ofSize: 19)
    }
    /// 我的家居贷Label
    let myLoan = UILabel().then{
        $0.textColor = .hex(hexString: "#666666")
        $0.text = "家居贷"
        $0.font = .systemFont(ofSize: 12)
    }
    /// 订单相关背景按钮
    let orderWhiteBg = UIView().then{
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
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
    /// 我的优惠券
    let myCoupon = UIButton().then{
        $0.setTitle("我的优惠券", for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.backgroundColor = .white
        $0.setImage(UIImage.init(named: "coupon"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .left
        $0.layoutButton(style: .Left, imageTitleSpace: 12.5, styleSpace: 26)
    }
    /// 我的售后🧵
    let myCouponLine = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
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
        
        self.addSubview(scroll)
        
        scroll.addSubview(themeBg)
        scroll.addSubview(mineLabel)
        scroll.addSubview(mineWhiteBg)
        scroll.addSubview(mineIcon)
        
        mineWhiteBg.addSubview(mineName)
        
        //MARK:积分余额家居贷
        mineWhiteBg.addSubview(haveLoginView)
        haveLoginView.addSubview(integralBtn)
        integralBtn.addSubview(integral)
        integralBtn.addSubview(myIntegral)
        haveLoginView.addSubview(balanceBtn)
        balanceBtn.addSubview(balance)
        balanceBtn.addSubview(myBalance)
        haveLoginView.addSubview(loanBtn)
        loanBtn.addSubview(loan)
        loanBtn.addSubview(myLoan)
        
        ///MARK: 订单相关
        scroll.addSubview(orderWhiteBg)
        orderWhiteBg.addSubview(mineOrderBtn)
        mineOrderBtn.addTarget(self, action: #selector(tapMyAllOrder), for: .touchUpInside)
        orderWhiteBg.addSubview(mineOrderLabel)
        orderWhiteBg.addSubview(viewAllOrderLabel)
        orderWhiteBg.addSubview(rightArrow)
        orderWhiteBg.addSubview(myOrderLine)
        orderWhiteBg.addSubview(notPayOrder)
        orderWhiteBg.addSubview(notSendOrder)
        orderWhiteBg.addSubview(notObtainOrder)
        orderWhiteBg.addSubview(completeOrder)
        notPayOrder.addTarget(self, action: #selector(tapNotPayOrder), for: .touchUpInside)
        notSendOrder.addTarget(self, action: #selector(tapNotSendOrder), for: .touchUpInside)
        notObtainOrder.addTarget(self, action: #selector(tapNotObtainOrder), for: .touchUpInside)
        completeOrder.addTarget(self, action: #selector(tapCompleteOrder), for: .touchUpInside)
        
        //MARK:还未登录
        mineWhiteBg.addSubview(logoutBgView)
        logoutBgView.addSubview(tipLoginLabel)
        logoutBgView.addSubview(wechatLoginBtn)
        wechatLoginBtn.addTarget(self, action: #selector(tapWechatLogin), for: .touchUpInside)
        
        //MARK: 收藏售后优惠券
        scroll.addSubview(operationWhiteBg)
        operationWhiteBg.addSubview(myCoupon)
        operationWhiteBg.addSubview(myCouponLine)
        operationWhiteBg.addSubview(myAfterSales)
        operationWhiteBg.addSubview(myCollection)
        operationWhiteBg.addSubview(myObtainAddress)
        operationWhiteBg.addSubview(aboutOus)
        operationWhiteBg.addSubview(myAfterSalesLine)
        operationWhiteBg.addSubview(myCollectionLine)
        operationWhiteBg.addSubview(myObtainAddressLine)
        myCoupon.addTarget(self, action: #selector(tapMyCoupon), for: .touchUpInside)
        myAfterSales.addTarget(self, action: #selector(tapMyAfterSales), for: .touchUpInside)
        myCollection.addTarget(self, action: #selector(tapMyCollection), for: .touchUpInside)
        myObtainAddress.addTarget(self, action: #selector(tapObtainAddress), for: .touchUpInside)
        aboutOus.addTarget(self, action: #selector(tapAboutOus), for: .touchUpInside)
        
        //MARK:scroll
        scroll.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //MARK:绿色背景
        themeBg.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(177.5 + statusbarHeight)
        }
        //MARK:个人中心
        mineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(statusbarHeight)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:个人信息的白色背景
        mineWhiteBg.snp.makeConstraints { (make) in
            make.top.equalTo(mineLabel.snp.bottom).offset(49)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(155)
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
            make.top.equalTo(mineIcon.snp.bottom).offset(8)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        //MARK:登录后的背景
        haveLoginView.isHidden = true
        haveLoginView.snp.makeConstraints { (make) in
            make.width.bottom.left.equalToSuperview()
            make.top.equalTo(mineName.snp.bottom)
        }
        //MARK:我的积分按钮
        integralBtn.snp.makeConstraints { (make) in
            make.height.equalTo(68)
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo((screenWidth-30)/3)
        }
        //MARK:积分数
        integral.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        //MARK:我的积分label
        myIntegral.snp.makeConstraints { (make) in
            make.top.equalTo(integral.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        //MARK:我的余额按钮
        balanceBtn.snp.makeConstraints { (make) in
            make.height.equalTo(68)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(integralBtn.snp.right)
            make.width.equalTo((screenWidth-30)/3)
        }
        //MARK:余额数
        balance.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        //MARK:我的余额label
        myBalance.snp.makeConstraints { (make) in
            make.top.equalTo(integral.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        //MARK:我的家居贷按钮
        loanBtn.snp.makeConstraints { (make) in
            make.height.equalTo(68)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(balanceBtn.snp.right)
            make.width.equalTo((screenWidth-30)/3)
        }
        //MARK:家居贷数
        loan.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        //MARK:我的家居贷label
        myLoan.snp.makeConstraints { (make) in
            make.top.equalTo(integral.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        //MARK:订单相关的背景
        orderWhiteBg.snp.makeConstraints { (make) in
            make.top.equalTo(mineWhiteBg.snp.bottom).offset(15)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(108)
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
            make.width.equalTo((screenWidth-30)/4)
        }
        //MARK:待发货
        notSendOrder.snp.makeConstraints { (make) in
            make.top.equalTo(myOrderLine.snp.bottom)
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
            make.left.equalTo(notPayOrder.snp.right)
            make.width.equalTo((screenWidth-30)/4)
        }
        //MARK:待收货
        notObtainOrder.snp.makeConstraints { (make) in
            make.top.equalTo(myOrderLine.snp.bottom)
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
            make.left.equalTo(notSendOrder.snp.right)
            make.width.equalTo((screenWidth-30)/4)
        }
        //MARK:已完成
        completeOrder.snp.makeConstraints { (make) in
            make.top.equalTo(myOrderLine.snp.bottom)
            make.height.equalTo(68)
            make.bottom.equalToSuperview()
            make.left.equalTo(notObtainOrder.snp.right)
            make.width.equalTo((screenWidth-30)/4)
        }
        
        
        //MARK:未登录的背景
        logoutBgView.isHidden = false
        logoutBgView.snp.makeConstraints { (make) in
            make.width.bottom.left.equalToSuperview()
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
            make.top.equalTo(tipLoginLabel.snp.bottom).offset(12)
            make.height.equalTo(44)
        }
        
        //MARK:菜单的背景
        operationWhiteBg.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(orderWhiteBg.snp.bottom).offset(15)
            make.height.equalTo(44 * 5)
        }
        //MARK:我的优惠券
        myCoupon.snp.makeConstraints { (make) in
            make.width.top.left.equalToSuperview()
            make.height.equalTo(44)
        }
        //MARK:我的优惠券🧵
        myCouponLine.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(myCoupon.snp.bottom)
        }
        //MARK:我的售后
        myAfterSales.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalTo(myCoupon.snp.bottom)
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
        
        notPayOrder.setButtonShowType(.Bottom)
        notSendOrder.setButtonShowType(.Bottom)
        notObtainOrder.setButtonShowType(.Bottom)
        completeOrder.setButtonShowType(.Bottom)
        
        scroll.addSubview(logout)
        logout.isHidden = true
        //MARK:退出登录
        logout.snp.makeConstraints { (make) in
            make.top.equalTo(operationWhiteBg.snp.bottom).offset(40)
            make.width.equalToSuperview().inset(15)
            make.centerX.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        logout.addTarget(self, action: #selector(tapLogout), for: .touchUpInside)
        
    }
    
    var loginData: APILoginDataModel? {
        didSet{
            guard let loginData = loginData else {
                UIView.animate(withDuration: 0.5) {
                    self.haveLoginView.isHidden = true
                    self.logoutBgView.isHidden = false
                    self.logout.isHidden = true
                    self.mineName.text = "Hi~欢迎来到懂家"
                    self.mineIcon.image = UIImage.init(named: "default_icon")
                }
                return
            }
            UIView.animate(withDuration: 0.5) {
                self.haveLoginView.isHidden = false
                self.logoutBgView.isHidden = true
                self.mineName.text = loginData.nickname
                self.mineIcon.load(loginData.avatar_url)
                self.logout.isHidden = false
            }
            
        }
    }
    
    @objc func tapMyAllOrder(){
        delegate?.myAllOrder()
    }
    
    @objc func tapNotPayOrder(){
        delegate?.notPayOrder()
    }
    
    @objc func tapNotSendOrder(){
        delegate?.notSendOrder()
    }
    
    @objc func tapNotObtainOrder(){
        delegate?.notObtainOrder()
    }
    
    @objc func tapCompleteOrder(){
        delegate?.completeOrder()
    }
    
    @objc func tapMyCoupon(){
        delegate?.myCoupon()
    }
    
    @objc func tapMyAfterSales(){
        delegate?.myAfterSales()
    }
    
    @objc func tapMyCollection(){
        delegate?.myCollection()
    }
    
    @objc func tapObtainAddress(){
        delegate?.obtainAddress()
    }
    
    @objc func tapAboutOus(){
        delegate?.aboutOus()
    }
    
    @objc func tapWechatLogin(){

        delegate?.wechatLogin()
    }
    
    @objc func tapLogout(){
        
        delegate?.logout()
    }

}
