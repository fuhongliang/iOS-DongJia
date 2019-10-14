//
//  UStoreClassicCaseView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import SnapKit

class UStoreClassicCaseView: BaseView {
    
    let view = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 45))
    let titleLabel = UILabel().then{
        $0.text = "精品案例"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = UIColor.black
    }
    let btn = UIButton().then{
        $0.setImage(UIImage(named: "right_arrow"), for: .normal)
        $0.addTarget(self, action: #selector(countAction), for: .touchUpInside)
        $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 11)
    }

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
        self.backgroundColor = .background
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.addSubview(view)
        view.addSubview(titleLabel)
        view.addSubview(btn)
        
        //MARK:头部
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
        }
        
        //MARK:总数按钮
        btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalTo(titleLabel)
        }
        
        
        self.addSubview(collectionView)
        collectionView.collectionViewLayout = layout
        collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(view.snp.bottom)
            make.width.equalTo(screenWidth-30)
            make.centerX.equalToSuperview()
            self.heightConstraint = make.height.equalTo(160).constraint
        })
        
        let bottom = UIView()
        bottom.backgroundColor = .random
        self.addSubview(bottom)
        bottom.snp.makeConstraints { (make) in
            make.top.equalTo(collectionView.snp.bottom)
            make.bottom.centerX.equalToSuperview()
            make.size.equalTo(0)
        }
    }
    
    @objc func countAction(){
        showHUDInView(text: "共\(data.count)个", inView: topVC!.view, isClick: true)
    }
    
    var data: [store_classic_case_model] = [] {
        didSet{
            self.collectionView.reloadData()
            //更新collectionView的高度约束
//            let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
            btn.setTitle("共\(data.count)个", for: .normal)
            btn.setButtonShowType(.Left)
            heightConstraint?.update(offset: self.collectionView.contentSize.height)
        }
    }
    
}
extension UStoreClassicCaseView: UICollectionViewDelegate, UICollectionViewDataSource{
    
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
        showHUDInView(text: "精品案例\(indexPath.item)", inView: topVC!.view, isClick: true)
    }


}
