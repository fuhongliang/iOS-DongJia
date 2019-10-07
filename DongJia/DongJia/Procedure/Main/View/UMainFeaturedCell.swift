//
//  UMainFeaturedCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/17.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import SnapKit

class UMainFeaturedCell: UBaseTableViewCell {
    
    private let service = APIMainService()
    
    var heightConstraint:Constraint? = nil

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        
        $0.showsVerticalScrollIndicator = false
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.backgroundColor = .background
        
        $0.register(cellType: UFeaturedCell.self)
        
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical //设置滚动方向
        $0.itemSize = CGSize(width: screenWidth-30, height: 110)//设置cell的大小
        $0.minimumInteritemSpacing = 5
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 10, right: 0)
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
            self.heightConstraint = make.height.equalTo(0).constraint
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
    
    var model:[featured_list] = [] {
        didSet {
            //collectionView重新加载数据
            self.collectionView.reloadData()
            
            //更新collectionView的高度约束
            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            heightConstraint?.update(offset: contentSize.height)
            
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
}
extension UMainFeaturedCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return model.count == 0 ? 0 : 1;
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UFeaturedCell.self)
        cell.data = model[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO 商品详情跳转
        let vc = UIGoodsDetailController()
        topVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
