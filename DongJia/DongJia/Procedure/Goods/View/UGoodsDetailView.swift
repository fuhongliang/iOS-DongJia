//
//  UGoodsDetailView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/26.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

protocol UGoodsDetailViewProtocol {
    func buyNowAction()
    func addCartAction()
    func viewToCartAction()
    func collectionList()
}

class UGoodsDetailView: BaseView {
    
    var delegate: UGoodsDetailViewProtocol?

    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.frame = .zero
        $0.backgroundColor = UIColor.background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.register(cellType: UGoodsPicListCell.self)
        $0.register(cellType: UGoodsLimitedBuyCell.self)
        $0.register(cellType: UGoodsOrdinaryBuyCell.self)
        $0.register(cellType: UGoodsNameServiceCell.self)
        $0.register(cellType: UGoodsChooseAttrCell.self)
        $0.register(cellType: UGoodsStoreInfoCell.self)
        $0.register(cellType: UGoodsDetailWKWebViewCell.self)
    }
    /// 底部的白色背景
    let whiteBg = UIView().then{
        $0.backgroundColor = .white
    }
    /// 收藏按钮
    let collectionBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("收藏", for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.setImage(UIImage.init(named: "hollow_star"), for: .normal)
        $0.setImage(UIImage.init(named: "green_star"), for: .selected)
        $0.titleLabel?.font = .systemFont(ofSize: 11)
    }
    /// 购物车按钮
    let cartBtn = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("购物车", for: .normal)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.setImage(UIImage.init(named: "detail_shop_cart"), for: .normal)
//        $0.setImage(UIImage.init(named: "todo_img"), for: .selected)
        $0.titleLabel?.font = .systemFont(ofSize: 11)
    }
    /// 加入购物车按钮
    let addCartBtn = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#FDC721")
        $0.setTitle("加入购物车", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    /// 立即购买按钮
    let buyNowBtn = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#0EC262")
        $0.setTitle("立即购买", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    override func configUI() {
        
        self.addSubview(tableView)
        self.addSubview(whiteBg)
        whiteBg.addSubview(collectionBtn)
        whiteBg.addSubview(cartBtn)
        whiteBg.addSubview(addCartBtn)
        whiteBg.addSubview(buyNowBtn)
        buyNowBtn.addTarget(self, action: #selector(buyNowAction), for: .touchUpInside)
        
        //MARK:商品详情TableView
        tableView.snp.makeConstraints { (make) in
            make.top.width.left.equalToSuperview()
            make.height.equalTo(screenHeight-54)
        }
        
        //MARK:底部白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.bottom.width.left.equalToSuperview()
            make.height.equalTo(54)
        }
        
        //MARK:收藏按钮
        collectionBtn.snp.makeConstraints { (make) in
            make.left.height.top.equalToSuperview()
            make.width.equalTo(85)
        }
        
        //MARK:购物车按钮
        cartBtn.snp.makeConstraints { (make) in
            make.left.equalTo(collectionBtn.snp.right)
            make.top.height.equalToSuperview()
            make.width.equalTo(85)
        }
        
        //MARK:立即购买按钮
        buyNowBtn.snp.makeConstraints { (make) in
            make.right.height.top.equalToSuperview()
            make.width.equalTo(110)
        }
        
        //MARK:加入购物车按钮
        addCartBtn.snp.makeConstraints { (make) in
            make.top.height.equalToSuperview()
            make.width.equalTo(110)
            make.right.equalTo(buyNowBtn.snp.left)
        }
        collectionBtn.setButtonShowType(.Bottom)
        cartBtn.setButtonShowType(.Bottom)
        
    }
    @objc func buyNowAction(){
        delegate?.buyNowAction()
    }
    
}
