//
//  UMainHotCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import SnapKit

//MARK:爆款热卖cell
class UMainHotCell: UBaseTableViewCell {
    
    var heightConstraint:Constraint? = nil
    
    var horizontalView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        
        $0.showsVerticalScrollIndicator = false
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.backgroundColor = UIColor.white
        
        $0.register(cellType: UHotGoodsCell.self)
        
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical //设置滚动方向
        $0.itemSize = CGSize(width: hotCellWidth, height: hotCellWidth*0.9+40)//设置cell的大小
        $0.minimumInteritemSpacing = 6
        $0.sectionInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func configUI() {
        
        self.contentView.backgroundColor = UIColor.background
        
        let top = UIView()
        contentView.addSubview(top)
        top.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(1)
        }
        
        contentView.addSubview(horizontalView)
        horizontalView.collectionViewLayout = layout
        horizontalView.snp.makeConstraints({ (make) in
            make.top.equalTo(top)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            self.heightConstraint = make.height.equalTo(44).constraint
        })
        
        let bottom = UIView()
        contentView.addSubview(bottom)
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(horizontalView.snp.bottom)
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(1)
        }
        
        horizontalView.delegate = self
        horizontalView.dataSource = self
        
    }
    
    var model:[recommend_goods]? {
        didSet {
            guard model != nil else { return }
            
            //collectionView重新加载数据
            self.horizontalView.reloadData()
            
            //更新collectionView的高度约束
            let contentSize = self.horizontalView.collectionViewLayout.collectionViewContentSize
            heightConstraint?.update(offset: contentSize.height)

            self.horizontalView.collectionViewLayout.invalidateLayout()
        }
    }
    
}
extension UMainHotCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UHotGoodsCell.self)
        cell.data = model![indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO 商品详情跳转
        let vc = UIGoodsDetailController()
        topVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
