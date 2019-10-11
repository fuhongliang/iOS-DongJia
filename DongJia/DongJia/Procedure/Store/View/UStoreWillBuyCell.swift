//
//  UStoreWillBuyCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/11.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import SnapKit

class UStoreWillBuyCell: UBaseTableViewCell {

    var heightConstraint: Constraint? = nil
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        $0.showsVerticalScrollIndicator = false
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
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
        
        let top = UIView()
        top.backgroundColor = .random
        contentView.addSubview(top)
        top.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(0)
        }
        
        collectionView.collectionViewLayout = layout
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(top.snp.bottom)
            self.heightConstraint = make.height.equalTo(screenHeight).constraint
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let bottom = UIView()
        bottom.backgroundColor = .random
        contentView.addSubview(bottom)
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(0)
        }
    }
    
    var data: [store_goods_list]?{
        didSet{
            //            guard let data = data else { return }
            guard data != nil else { return }
            self.collectionView.reloadData()
            //更新collectionView的高度约束
            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            heightConstraint?.update(offset: contentSize.height)
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }

}
extension UStoreWillBuyCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
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
        showHUDInView(text: "\(indexPath.item)", inView: topVC!.view)
    }
    
}