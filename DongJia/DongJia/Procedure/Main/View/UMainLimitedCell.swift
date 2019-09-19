//
//  UMainLimitedCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/12.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

//MARK:限时抢购
class UMainLimitedCell: UBaseTableViewCell {

    var whiteBg = UIView().then{
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .horizontal //设置滚动方向
        $0.itemSize = CGSize(width: 120, height: 165)//设置cell的大小
        $0.minimumInteritemSpacing = 5
        $0.sectionInset = UIEdgeInsets.init(top: 8, left: 10, bottom: -8, right: 10)
    }
    
    override func configUI() {
        
        //白色背景
        contentView.addSubview(whiteBg)
        contentView.backgroundColor = UIColor.background
        //MARK:白色背景
        whiteBg.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(165)
            make.top.bottom.centerX.equalToSuperview()
        }
        
        let horizontalView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
            $0.collectionViewLayout = layout
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = UIColor.white
            $0.register(cellType: ULimitedTimeCell.self)
            
            contentView.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.right.top.height.equalTo(whiteBg)
            })
        }
        
        horizontalView.delegate = self
        horizontalView.dataSource = self
        
    }
    
}

extension UMainLimitedCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1//model?.pic_list.count ?? 0 == 0 ? 0 :1;
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5//model?.pic_list.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ULimitedTimeCell.self)
        cell.data = "¥2999"

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showHUDInView(text: "\(indexPath.item)", inView: topVC!.view)
    }
    
}
