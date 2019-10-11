//
//  UStoreDesignTeamCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/11.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UStoreDesignTeamCell: UBaseTableViewCell {
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal //设置滚动方向
        $0.itemSize = CGSize(width: (screenWidth-150)/4, height: 112)//设置cell的大小
        $0.minimumInteritemSpacing = 15
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    let collectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 3
        $0.layer.masksToBounds = true
        $0.register(cellType: UDesignTeamCell.self)
    }
    override func configUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(collectionView)
        let top = UIView()
        contentView.addSubview(top)
        top.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(1)
        }
        collectionView.collectionViewLayout = layout
        //MARK:设计师列表
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(top)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(112)
        }
        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then{
//            $0.showsHorizontalScrollIndicator = false
//            $0.backgroundColor = .white
//            $0.layer.cornerRadius = 3
//            $0.layer.masksToBounds = true
//            $0.register(cellType: UDesignTeamCell.self)
//
//            contentView.addSubview($0)
//            $0.snp.makeConstraints({ (make) in
//                make.top.equalTo(top)
//                make.width.equalToSuperview().inset(15)
//                make.centerX.equalToSuperview()
//            })
//        }
        
        let bottom = UIView()
        contentView.addSubview(bottom)
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(1)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    var designerList: [String]?{
        didSet{
            guard let designerList = designerList else { return }
            collectionView.reloadData()
        }
    }

}
extension UStoreDesignTeamCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return designerList?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UDesignTeamCell.self)
        cell.designerInfo = ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showHUDInView(text: "\(indexPath.item)", inView: topVC!.view)
    }
    
}
