//
//  UStoreClassicCaseCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import SnapKit

class UStoreClassicCaseCell: UBaseTableViewCell {
    
    var heightConstraint: Constraint? = nil

    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .background

        $0.register(cellType: UClassicCaseCell.self)
    }

    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal //设置滚动方向
        $0.estimatedItemSize = CGSize(width: collectionCellWidth, height: 160);
        $0.itemSize = CGSize(width: collectionCellWidth, height: 160)//设置cell的大小
        $0.minimumInteritemSpacing = 5
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func configUI() {
        contentView.backgroundColor = .background
        collectionView.delegate = self
        collectionView.dataSource = self

        let top = UIView()
        top.backgroundColor = .random
        contentView.addSubview(top)
        top.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(5)
        }

        contentView.addSubview(collectionView)
        collectionView.collectionViewLayout = layout
        collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(top.snp.bottom)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            self.heightConstraint = make.height.equalTo(160).constraint
        })

        let bottom = UIView()
        bottom.backgroundColor = .random
        contentView.addSubview(bottom)
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(5)
        }
    }

    var data: [store_classic_case_model] = [] {
        didSet{
//            guard let data = data else { return }
//            self.collectionView.layoutIfNeeded()
            //更新collectionView的高度约束
//            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
//            heightConstraint?.update(offset: self.collectionView.contentSize.height)
//            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }

}
extension UStoreClassicCaseCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UClassicCaseCell.self)
        cell.data = self.data[indexPath.item]

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showHUDInView(text: "\(indexPath.item)", inView: topVC!.view)
    }

}
