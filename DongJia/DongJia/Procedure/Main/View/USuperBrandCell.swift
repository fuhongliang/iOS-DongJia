//
//  USuperBrandCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class USuperBrandCell: UBaseCollectionViewCell {
    
    var goods1Action:(() -> ())?
    var goods2Action:(() -> ())?
    var goods3Action:(() -> ())?
    
    let bgColorView = UIView().then{ //背景颜色View
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    let bgPicView = UIImageView() // 背景图片View
    
    let shopIcon = UIImageView().then{ //商店头像
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.image = UIImage.init(named: "default_icon")
    }
    let shopName = UILabel().then{ //商店名称
        $0.text = "商店名称"
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.boldSystemFont(ofSize: 14)
    }
    let goodsCount = UILabel().then{ //商品总数
        $0.text = "共10件商品"
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 11)
    }
    
    //MARK:商品1
    let goods1BgView = UIView().then{ //商品1白色背景
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
    }
    let goods1PicView = UIImageView()//商品1图片
    let goods1CurrentPrice = UILabel().then{//商品1当前的价格
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.hex(hexString: "#F61616")
    }
    let goods1BeforePrice = UILabel().then{//商品1之前的价格
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor.hex(hexString: "#999999")
    }
    let goods1Btn = UIButton()//商品1点击按钮
    
    //MARK:商品2
    let goods2BgView = UIView().then{//商品2白色背景
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
    }
    let goods2PicView = UIImageView()//商品2图片
    let goods2CurrentPrice = UILabel().then{//商品2当前的价格
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.hex(hexString: "#F61616")
    }
    let goods2BeforePrice = UILabel().then{//商品2之前的价格
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor.hex(hexString: "#999999")
    }
    let goods2Btn = UIButton()//商品2点击按钮
    
    //MARK:商品3
    let goods3BgView = UIView().then{//商品3白色背景
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
    }
    let goods3PicView = UIImageView()//商品3图片
    let goods3CurrentPrice = UILabel().then{//商品3当前的价格
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.textColor = UIColor.hex(hexString: "#F61616")
    }
    let goods3BeforePrice = UILabel().then{//商品3之前的价格
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = UIColor.hex(hexString: "#999999")
    }
    let goods3Btn = UIButton()//商品3点击按钮
    
    override func configUI() {
        
        contentView.backgroundColor = UIColor.background
        
        contentView.addSubview(bgColorView)
        contentView.addSubview(bgPicView)
        contentView.addSubview(shopIcon)
        contentView.addSubview(shopName)
        contentView.addSubview(goodsCount)
        
      
        
        bgColorView.backgroundColor = UIColor.hex(hexString: "#D8D9E0")
        bgPicView.image = UIImage.init(named: "todo_img")
        goods1CurrentPrice.text = "¥1000"
        goods1BeforePrice.text = "¥999"
        goods2CurrentPrice.text = "¥1000"
        goods2BeforePrice.text = "¥999"
        goods3CurrentPrice.text = "¥1000"
        goods3BeforePrice.text = "¥999"
        
        //MARK:背景颜色图
        bgColorView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(202)
            make.top.bottom.centerX.equalToSuperview()
        }
        
        //MARK:背景图片(右上角)
        bgPicView.snp.makeConstraints { (make) in
            make.right.top.equalTo(bgColorView)
            make.width.height.equalToSuperview().dividedBy(2)
        }
        
        //MARK:商店图标
        shopIcon.snp.makeConstraints { (make) in
            make.left.top.equalTo(bgColorView).offset(12)
            make.size.equalTo(33)
        }
        
        //MARK:商店名称
        shopName.snp.makeConstraints { (make) in
            make.left.equalTo(shopIcon.snp.right).offset(10)
            make.top.equalTo(shopIcon)
        }
        
        //MARK:商品总数
        goodsCount.snp.makeConstraints { (make) in
            make.left.equalTo(shopIcon.snp.right).offset(10)
            make.bottom.equalTo(shopIcon)
        }
        
        
    }
    
    func configGoods1(){
        //重用时删除之前已经添加的
        goods1BgView.removeFromSuperview()
        guard (data?.goods_list.count ?? 0 > 0 || catStoreData?.goods_list.count ?? 0 > 0) else { return }
        
        contentView.addSubview(goods1BgView)
        goods1BgView.addSubview(goods1PicView)
        goods1BgView.addSubview(goods1BeforePrice)
        goods1BgView.addSubview(goods1CurrentPrice)
        goods1BgView.addSubview(goods1Btn)
        
        var coverPic = ""
        if(data != nil){
            coverPic = data!.goods_list[0].cover_pic
        } else {
            coverPic = catStoreData!.goods_list[0].cover_pic
        }
        goods1PicView.load(coverPic)
        
        var originalPrice = ""
        if(data != nil){
            originalPrice = data!.goods_list[0].original_price
        } else {
            originalPrice = catStoreData!.goods_list[0].original_price
        }
        goods1BeforePrice.text = originalPrice
        
        var price = ""
        if(data != nil){
            price = data!.goods_list[0].price
        } else {
            price = catStoreData!.goods_list[0].price
        }
        goods1CurrentPrice.text = price
        
        //MARK:商品1白色背景
        goods1BgView.snp.makeConstraints { (make) in
            make.height.equalTo(125)
            make.width.equalTo(bgColorView.snp.width).dividedBy(3).inset(8)
            make.top.equalTo(shopIcon.snp.bottom).offset(20)
            make.left.equalTo(bgColorView).offset(12)
        }
        
        //MARK:商品1图片
        goods1PicView.snp.makeConstraints { (make) in
            make.top.width.left.equalTo(goods1BgView)
            make.height.equalTo(100)
        }
        
        //MARK:商品1价格
        goods1CurrentPrice.snp.makeConstraints { (make) in
            make.left.equalTo(goods1BgView).offset(5)
            make.top.equalTo(goods1PicView.snp.bottom).offset(6)
        }
        
        //MARK:商品1原价
        goods1BeforePrice.snp.makeConstraints { (make) in
            make.right.equalTo(goods1BgView).offset(-5)
            make.bottom.equalTo(goods1CurrentPrice)
        }
        //MARK:商品1按钮
        goods1Btn.snp.makeConstraints { (make) in
            make.size.top.left.equalTo(goods1BgView)
        }
        goods1Btn.addTarget(self, action: #selector(tapGoods1), for: .touchUpInside)
        
    }
    
    func configGoods2(){
        //重用时删除之前已经添加的
        goods2BgView.removeFromSuperview()
        guard (data?.goods_list.count ?? 0 > 1 || catStoreData?.goods_list.count ?? 0 > 1) else { return }
        
        contentView.addSubview(goods2BgView)
        goods2BgView.addSubview(goods2PicView)
        goods2BgView.addSubview(goods2BeforePrice)
        goods2BgView.addSubview(goods2CurrentPrice)
        goods2BgView.addSubview(goods2Btn)
        
        var coverPic = ""
        if(data != nil){
            coverPic = data!.goods_list[1].cover_pic
        } else {
            coverPic = catStoreData!.goods_list[1].cover_pic
        }
        goods2PicView.load(coverPic)
        
        var originalPrice = ""
        if(data != nil){
            originalPrice = data!.goods_list[1].original_price
        } else {
            originalPrice = catStoreData!.goods_list[1].original_price
        }
        goods2BeforePrice.text = originalPrice
        
        var price = ""
        if(data != nil){
            price = data!.goods_list[1].price
        } else {
            price = catStoreData!.goods_list[1].price
        }
        goods2CurrentPrice.text = price
        
//        goods2PicView.load(data!.goods_list[1].cover_pic)
//        goods2BeforePrice.text = data!.goods_list[1].original_price
//        goods2CurrentPrice.text = data?.goods_list[1].price
        
        //MARK:商品2白色背景
        goods2BgView.snp.makeConstraints { (make) in
            make.height.equalTo(125)
            make.width.equalTo(bgColorView.snp.width).dividedBy(3).inset(8)
            make.top.equalTo(shopIcon.snp.bottom).offset(20)
            make.centerX.equalTo(bgColorView)
        }
        
        //MARK:商品2图片
        goods2PicView.snp.makeConstraints { (make) in
            make.top.width.left.equalTo(goods2BgView)
            make.height.equalTo(100)
        }
        
        //MARK:商品2价格
        goods2CurrentPrice.snp.makeConstraints { (make) in
            make.left.equalTo(goods2BgView).offset(5)
            make.top.equalTo(goods2PicView.snp.bottom).offset(6)
        }
        
        //MARK:商品1原价
        goods2BeforePrice.snp.makeConstraints { (make) in
            make.right.equalTo(goods2BgView).offset(-5)
            make.bottom.equalTo(goods2CurrentPrice)
        }
        //MARK:商品2按钮
        goods2Btn.snp.makeConstraints { (make) in
            make.size.top.left.equalTo(goods2BgView)
        }
        goods2Btn.addTarget(self, action: #selector(tapGoods2), for: .touchUpInside)
        
    }
    
    func configGoods3(){
        //重用时删除之前已经添加的
        goods3BgView.removeFromSuperview()
        guard (data?.goods_list.count ?? 0 > 2 || catStoreData?.goods_list.count ?? 0 > 2) else { return }
        
        contentView.addSubview(goods3BgView)
        goods3BgView.addSubview(goods3PicView)
        goods3BgView.addSubview(goods3BeforePrice)
        goods3BgView.addSubview(goods3CurrentPrice)
        goods3BgView.addSubview(goods3Btn)
        
        var coverPic = ""
        if(data != nil){
            coverPic = data!.goods_list[2].cover_pic
        } else {
            coverPic = catStoreData!.goods_list[2].cover_pic
        }
        goods3PicView.load(coverPic)
        
        var originalPrice = ""
        if(data != nil){
            originalPrice = data!.goods_list[2].original_price
        } else {
            originalPrice = catStoreData!.goods_list[2].original_price
        }
        goods3BeforePrice.text = originalPrice
        
        var price = ""
        if(data != nil){
            price = data!.goods_list[2].price
        } else {
            price = catStoreData!.goods_list[2].price
        }
        goods3CurrentPrice.text = price
        
//        goods3PicView.load(data!.goods_list[2].cover_pic)
//        goods3BeforePrice.text = data!.goods_list[2].original_price
//        goods3CurrentPrice.text = data?.goods_list[2].price
        
        //MARK:商品3白色背景
        goods3BgView.snp.makeConstraints { (make) in
            make.height.equalTo(125)
            make.width.equalTo(bgColorView.snp.width).dividedBy(3).inset(8)
            make.top.equalTo(shopIcon.snp.bottom).offset(20)
            make.right.equalTo(bgColorView).offset(-12)
        }
        
        //MARK:商品3图片
        goods3PicView.snp.makeConstraints { (make) in
            make.top.width.left.equalTo(goods3BgView)
            make.height.equalTo(100)
        }
        
        //MARK:商品3价格
        goods3CurrentPrice.snp.makeConstraints { (make) in
            make.left.equalTo(goods3BgView).offset(5)
            make.top.equalTo(goods3PicView.snp.bottom).offset(6)
        }
        
        //MARK:商品3原价
        goods3BeforePrice.snp.makeConstraints { (make) in
            make.right.equalTo(goods3BgView).offset(-5)
            make.bottom.equalTo(goods3CurrentPrice)
        }
        //MARK:商品3按钮
        goods3Btn.snp.makeConstraints { (make) in
            make.size.top.left.equalTo(goods3BgView)
        }
        goods3Btn.addTarget(self, action: #selector(tapGoods3), for: .touchUpInside)
    }
    
    @objc func tapGoods1(){
        goods1Action?()
    }
    @objc func tapGoods2(){
        goods2Action?()
    }
    @objc func tapGoods3(){
        goods3Action?()
    }
    
    /// 首页中的cell数据填充
    var data: new_mch_list? {
        didSet {
            guard let data = data else { return }
            bgColorView.backgroundColor = UIColor.hex(hexString: data.mch_color)
            bgPicView.load(data.header_bg)
            shopName.text = data.mch_name
            shopIcon.load(data.mch_logo)
            
            configGoods1()
            configGoods2()
            configGoods3()
        }
    }
    
    /// 分类中的cell数据填充
    var catStoreData: cat_mch_list_model? {
        didSet {
            guard let catStoreData = catStoreData else { return }
            bgColorView.backgroundColor = UIColor.hex(hexString: catStoreData.mch_color)
            bgPicView.load(catStoreData.header_bg)
            shopName.text = catStoreData.mch_name
            shopIcon.load(catStoreData.logo)
            
            configGoods1()
            configGoods2()
            configGoods3()
        }
    }
    
}
