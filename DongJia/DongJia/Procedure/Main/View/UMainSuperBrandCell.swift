//
//  UMainSuperBrandCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import SnapKit

//MARK:超级品牌cell
class UMainSuperBrandCell: UBaseTableViewCell {
    
    var heightConstraint:Constraint? = nil
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        
        $0.showsVerticalScrollIndicator = false
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.backgroundColor = .background
        
        $0.register(cellType: USuperBrandCell.self)
        
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical //设置滚动方向
        $0.itemSize = CGSize(width: screenWidth-30, height: 202)//设置cell的大小
        $0.minimumInteritemSpacing = 10
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func configUI() {
        
        contentView.backgroundColor = .background
        
        let top = UIView()
        contentView.addSubview(top)
        top.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(1)
        }
        
        contentView.addSubview(collectionView)
        collectionView.collectionViewLayout = layout
        collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(top)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            self.heightConstraint = make.height.equalTo(44).constraint
        })
        
        let bottom = UIView()
        contentView.addSubview(bottom)
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(1)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    var model:[new_mch_list]? {
        didSet {
            guard model != nil else { return }
            
            //collectionView重新加载数据
            self.collectionView.reloadData()
            
            //更新collectionView的高度约束
            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            heightConstraint?.update(offset: contentSize.height)
            
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
}
extension UMainSuperBrandCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1//model?.pic_list.count ?? 0 == 0 ? 0 :1;
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: USuperBrandCell.self)
        cell.goods1Action = {
            showHUDInView(text: "\(indexPath.item)--1", inView: topVC!.view)
        }
        cell.goods2Action = {
            showHUDInView(text: "\(indexPath.item)--2", inView: topVC!.view)
        }
        cell.goods3Action = {
            showHUDInView(text: "\(indexPath.item)--3", inView: topVC!.view)
        }

        cell.data = model![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showHUDInView(text: "\(indexPath.item)", inView: topVC!.view)
    }
    
}
