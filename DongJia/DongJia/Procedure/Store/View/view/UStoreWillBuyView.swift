//
//  UStoreWillBuyView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import SnapKit

class UStoreWillBuyView: BaseView {

    let view = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 45))
    let titleLabel = UILabel().then{
        $0.text = "精选必买"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = UIColor.black
    }
    var heightConstraint: Constraint? = nil
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        $0.showsVerticalScrollIndicator = false
        
        $0.backgroundColor = .background
        $0.register(cellType: UMyCollectionCell.self)
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical //设置滚动方向
        $0.itemSize = CGSize(width: collectionCellWidth, height: 220)//设置cell的大小
        $0.minimumInteritemSpacing = 5
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func configUI() {
        self.backgroundColor = .background
        self.addSubview(view)
        view.addSubview(titleLabel)
        //MARK:标题
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
        }
        collectionView.collectionViewLayout = layout
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth-30)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
            self.heightConstraint = make.height.equalTo(screenHeight).constraint
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let bottom = UIView()
        self.addSubview(bottom)
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(1)
        }
    }
    
    var data: [store_goods_list]?{
        didSet{
            guard data != nil else { return }
            self.collectionView.reloadData()
            //更新collectionView的高度约束
            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            heightConstraint?.update(offset: contentSize.height)
        }
    }
    
    func setData(){
        //更新collectionView的高度约束
        
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        heightConstraint?.update(offset: contentSize.height)
    }
    
}
extension UStoreWillBuyView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return data == nil ? 0 : 1
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UMyCollectionCell.self)
        let goods = self.data![indexPath.item]
        cell.data = ["pic_url": goods.cover_pic,"name":goods.name,"price":goods.price,"origin_price":goods.original_price,"buy_num":goods.virtual_sales]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIGoodsDetailController()
        vc.goodsId = data![indexPath.item].id
        topVC?.navigationController?.pushViewController(vc, animated: true)
    }
    

}
