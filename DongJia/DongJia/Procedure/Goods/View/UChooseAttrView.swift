//
//  UChooseAttrView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/15.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import ZLCollectionViewFlowLayout

protocol UChooseAttrViewProtocol {
    func dismissAction()
}

class UChooseAttrView: BaseView {
    
    var delegate: UChooseAttrViewProtocol?
    
    let 猪刚鬣 = "http://pics0.baidu.com/feed/c8177f3e6709c93d0abb3b1a22d37fd9d3005481.jpeg?token=343555ad077cf67cf7a9a49e9c2436eb&s=984BB14C43B2B3701A5A15170300E0C8"
    
    let arrayAttrs = [["超轻体力活动(程序员)超轻体力活动(程序员)超轻体力活动(程序员)超轻体力活动(程序员)超轻体力活动(程序员)超轻体力活动(程序员)","轻体力活动(学生,白领)","中体力活动(业务员,普通工人)","重体力活动(运动员,装卸工)","超重体力活","中体力活动(业务员,普通工人)","重体力活动(运动员,装卸工)","超重体力活"],["职业公司","非职业公司","半职业半非职业公司","没有公司","非职业公司","半职业半非职业公司"],["我喜欢看电影","我喜欢看书","我喜欢看电影又喜欢看书","你喜欢看电影个屁","我喜欢看书","我喜欢看电影又喜欢看书"]]
    var chooseArrayAttrs = [[Bool]]()
    
    
    /// 白色背景
    let whiteBg = UIView().then{
        $0.backgroundColor = .white
    }
    
    /// 商品图片
    let goodsPic = UIImageView().then{
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
    }
    /// 关闭按钮
    let close = UIButton().then{
        $0.setImage(UIImage.init(named: "delete_address"), for: .normal)
    }
    /// 价格
    let priceLabel = UILabel().then{
        $0.textColor = .hex(hexString: "#FD5757")
        $0.font = .boldSystemFont(ofSize: 18)
    }
    /// 库存数量Label
    let stockLabel = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 当前选择的商品属性
    let chooseAttr = UILabel().then{
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 14)
    }
    /// 规格列表
    let attrCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.bounces = true
        $0.allowsMultipleSelection = true
        $0.register(supplementaryViewType: UHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        $0.register(cellType: UChooseAttrCell.self)
        $0.register(cellType: UAddNumberCell.self)
    }
//    let layout = UICollectionViewFlowLayout().then{
//        $0.scrollDirection = .vertical //设置滚动方向
//        $0.estimatedItemSize = CGSize(width: (screenWidth)/4, height: 30)
//        $0.minimumInteritemSpacing = 7.5
//        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//    }
    // 创建一个有多布局的layout
    let flowLayout = ZLCollectionViewVerticalLayout().then{
        $0.canDrag = true
        $0.header_suspension = false
    }
    
    
    /// 加入购物车
    let addCart = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#FDC721")
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.setTitle("加入购物车", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }
    /// 立即购买
    let buyNow = UIButton().then{
        $0.backgroundColor = .hex(hexString: "#0EC262")
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.setTitle("立即购买", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
    }

    override func configUI() {
        
        for (index,item) in arrayAttrs.enumerated() {
            chooseArrayAttrs.append([Bool]())
            for _ in item {
                chooseArrayAttrs[index].append(false)
            }
        }
        goodsPic.load(猪刚鬣)
        priceLabel.text = "￥3398-5999"
        stockLabel.text = "库存充足"
        chooseAttr.text = "选择 颜色 尺码"
        attrCollection.delegate = self
        attrCollection.dataSource = self
        close.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        flowLayout.delegate = self
        attrCollection.collectionViewLayout = flowLayout
        
        self.addSubview(whiteBg)
        whiteBg.addSubview(goodsPic)
        whiteBg.addSubview(close)
        whiteBg.addSubview(priceLabel)
        whiteBg.addSubview(stockLabel)
        whiteBg.addSubview(chooseAttr)
        whiteBg.addSubview(attrCollection)
        whiteBg.addSubview(addCart)
        whiteBg.addSubview(buyNow)
        
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        //MARK:商品图片
        goodsPic.snp.makeConstraints { (make) in
            make.size.equalTo(70)
            make.top.left.equalToSuperview().offset(15)
        }
        
        //MARK:关闭按钮
        close.snp.makeConstraints { (make) in
            make.top.equalTo(goodsPic)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(15)
        }
        
        //MARK:价格
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(goodsPic.snp.right).offset(14)
            make.top.equalTo(goodsPic).offset(5)
        }
        //MARK:库存
        stockLabel.snp.makeConstraints { (make) in
            make.left.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
        }
        //MARK:已选择的规格
        chooseAttr.snp.makeConstraints { (make) in
            make.bottom.equalTo(goodsPic).offset(-5)
            make.left.equalTo(priceLabel)
        }
        //MARK:加入购物车
        addCart.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-7)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(screenWidth/2-22.5)
            make.height.equalTo(40)
        }
        //MARK:立即购买
        buyNow.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-7)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(screenWidth/2-22.5)
            make.height.equalTo(40)
        }
        //MARK:规格列表
        attrCollection.snp.makeConstraints { (make) in
            make.width.left.equalToSuperview().inset(15)
            make.top.equalTo(goodsPic.snp.bottom).offset(25)
            make.height.equalTo(screenHeight/2-15)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    @objc func closeAction(){
        delegate?.dismissAction()
    }

}

extension UChooseAttrView: ZLCollectionViewBaseFlowLayoutDelegate{
    // 返回当前的布局类型
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
        if section == arrayAttrs.count {
            return ClosedLayout
        }
        return LabelLayout
    }
    
}

extension UChooseAttrView: UICollectionViewDelegate, UICollectionViewDataSource{
    // 返回section的数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayAttrs.count+1
    }
    
    // 返回section中item的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == arrayAttrs.count {
            return 1
        }
        return arrayAttrs[section].count
    }
    
    // 返回头部View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: UHeaderView.self)
        if indexPath.section == arrayAttrs.count{
            headerView.attrGroupName.text = "数量"
        } else {
            headerView.attrGroupName.text = "Kotlin开发"
        }
        return headerView
    }
    
    // 返回header的高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 40)
    }
    
    // 创建cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 数量cell
        if indexPath.section == arrayAttrs.count{
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UAddNumberCell.self)
            return cell
        }
        // 普通cell
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UChooseAttrCell.self)
        // 返回cell
        cell.isChoose = chooseArrayAttrs[indexPath.section][indexPath.item]
        cell.name = arrayAttrs[indexPath.section][indexPath.row]
        return cell
    }
    
    // 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == arrayAttrs.count{
            // 如果是数量加减 则没有点击事件
            return
        }
        for (index, _) in chooseArrayAttrs[indexPath.section].enumerated() {
            // 设置选中并且重复点击 取消选中
            if (index == indexPath.row && !chooseArrayAttrs[indexPath.section][index]){
                chooseArrayAttrs[indexPath.section][index] = true
            } else {
                chooseArrayAttrs[indexPath.section][index] = false
            }
        }
        collectionView.reloadData()
    }
    
    // 返回cell的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == arrayAttrs.count{
            return CGSize(width: screenWidth-30, height: 30)
        }
        // 返回文本的宽度
        let label: NSString = arrayAttrs[indexPath.section][indexPath.row] as NSString
        return CGSize(width: label.boundingRect(with: CGSize(width: 1000000, height: 20), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue), attributes: [.font: UIFont.systemFont(ofSize: 14)], context: nil).width+14, height: 30)
    }
    
    // 如果布局是ClosedLayout(瀑布流) 返回列数
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, columnCountOfSection section: Int) -> Int {
        return 1
    }
    
    // 返回section的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 返回item的间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // 返回每个section的边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
}
