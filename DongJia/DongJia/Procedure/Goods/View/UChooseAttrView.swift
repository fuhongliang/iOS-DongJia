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
    func buyNowAction()
}

class UChooseAttrView: BaseView {
    
    var delegate: UChooseAttrViewProtocol?
    
    private var service = APIGoodsService()
    
    let 猪刚鬣 = "http://pics0.baidu.com/feed/c8177f3e6709c93d0abb3b1a22d37fd9d3005481.jpeg?token=343555ad077cf67cf7a9a49e9c2436eb&s=984BB14C43B2B3701A5A15170300E0C8"
    
    /// 规格组数据
    var attrData:[goods_detail_attr_group_list]! {
        didSet{
            for (index,item) in attrData.enumerated() {
                chooseArrayAttrs.append([Bool]())
                for _ in item.attr_list {
                    chooseArrayAttrs[index].append(false)
                }
            }
        }
    }
    
    /// 记录当前选择的状态
    var chooseArrayAttrs = [[Bool]]()
    
    /// 存储已经选择了规格组中的对应的属性
    var alreadyChooseAttrGroupId = [Int:Int]()
    
    /// 当前商品ID
    var currentGoodsId: String = ""
    /// 当前是否选择全部的商品属性
    
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
        buyNow.addTarget(self, action: #selector(buyNowAction), for: .touchUpInside)
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
    @objc func buyNowAction(){
        guard alreadyChooseAttrGroupId.count == attrData.count else {
            for (index, item) in attrData.enumerated(){
                if alreadyChooseAttrGroupId[index] == nil {
                    showHUDInView(text: "请选择\(item.attr_group_name)", inView: self)
                    attrCollection.scrollToItem(at: IndexPath(item: 0, section: index), at: .top, animated: true)
                }
            }
            return
        }
        delegate?.buyNowAction()
    }
    
    /// 获取该属性的商品的信息(库存,价格,图片)
    func getAttrInfo(indexPath: IndexPath){
        // 判断当前选择的属性 是否全部选择完成
        // 存储选择的商品属性ID
        var chooseId:[Int] = [Int]()
        for (index, item) in chooseArrayAttrs.enumerated(){
            for (i, isChoose) in item.enumerated(){
                if (isChoose) {
                    chooseId.append(attrData[index].attr_list[i].attr_id)
                    alreadyChooseAttrGroupId[index] = attrData[index].attr_group_id
                    break
                }
            }
        }
        guard chooseId.count == attrData.count else { return }
        service.getGoodsAttrData(goodsId: currentGoodsId, attr_list: chooseId, { (AttrData) in
            self.goodsPic.load(AttrData.data?.pic)
            self.priceLabel.text = "¥\(AttrData.data?.price ?? "-")"
            self.stockLabel.text = "库存\(AttrData.data?.num ?? 0)"
        }) { (APIErrorModel) in
            
        }
    }

}

extension UChooseAttrView: ZLCollectionViewBaseFlowLayoutDelegate{
    // 返回当前的布局类型
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
        if section == attrData.count {
            return ClosedLayout
        }
        return LabelLayout
    }
    
}

extension UChooseAttrView: UICollectionViewDelegate, UICollectionViewDataSource{
    // 返回section的数量
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return attrData.count+1
    }
    
    // 返回section中item的数量
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == attrData.count {
            return 1
        }
        return attrData[section].attr_list.count
    }
    
    // 返回头部View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: UHeaderView.self)
        if indexPath.section == attrData.count{
            headerView.attrGroupName.text = "数量"
        } else {
            headerView.attrGroupName.text = self.attrData?[indexPath.section].attr_group_name
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
        if indexPath.section == attrData.count{
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UAddNumberCell.self)
            return cell
        }
        // 普通cell
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UChooseAttrCell.self)
        // 返回cell
        cell.isChoose = chooseArrayAttrs[indexPath.section][indexPath.item]
        cell.name = attrData?[indexPath.section].attr_list[indexPath.item].attr_name ?? ""
        return cell
    }
    
    // 点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == attrData.count{
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
        self.getAttrInfo(indexPath: indexPath)
        collectionView.reloadData()
    }
    
    // 返回cell的size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == attrData.count{
            return CGSize(width: screenWidth-30, height: 30)
        }
        // 返回文本的宽度
        let label: NSString = attrData[indexPath.section].attr_list[indexPath.row].attr_name as NSString
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
