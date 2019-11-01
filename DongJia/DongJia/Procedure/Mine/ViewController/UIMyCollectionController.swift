//
//  UIMyCollectionController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

/// 我的收藏页面
class UIMyCollectionController: UBaseViewController {
    
    private let service = APIMineServices()
    
    var collectionListData: [collection_list_model]? {
        didSet{
            guard collectionListData == nil else {
                collectionView.reloadData()
                return
            }
        }
    }
    
    var currentPage = 1 // 当前精选的页数
    var pageCount = 0 // 精选的总页数
    /// 当前是否已经是精选列表的最大页数
    var isMaxPage: Bool{
        get {
            return currentPage >= pageCount
        }
    }

    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        $0.showsVerticalScrollIndicator = false
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.backgroundColor = .background
        $0.register(cellType: UMyCollectionCell.self)
    }
    
    let layout = UICollectionViewFlowLayout().then{
        $0.scrollDirection = .vertical //设置滚动方向
        $0.estimatedItemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.minimumInteritemSpacing = 5
        $0.sectionInset = UIEdgeInsets.init(top: 15, left: 0, bottom: 15, right: 0)
    }
    
    override func configUI() {
        collectionView.collectionViewLayout = layout
        collectionView.uFoot = URefreshFooter { [weak self] in self?.getCollectionListData() }
        collectionView.uempty = UEmptyView { [weak self] in self?.getCollectionListData() }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.top.centerX.height.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        getCollectionListData()
    }
    
    /// 获取收藏列表
    func getCollectionListData(){
        checkLoginState {
            service.getCollectionList(page: currentPage, { (CollectionList) in
                self.pageCount = CollectionList.data.page_count
                if (self.currentPage == 1){
                    self.collectionListData = CollectionList.data.list
                } else {
                    self.collectionListData?.append(contentsOf: CollectionList.data.list)
                }
                
                if (self.isMaxPage){
                    self.collectionView.uFoot.endRefreshingWithNoMoreData()
                } else {
                    self.collectionView.uFoot.endRefreshing()
                }
                self.currentPage += 1
            }) { (APIErrorModel) in
                
            }
        }
    }
    
}

extension UIMyCollectionController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return (collectionListData == nil || collectionListData?.isEmpty ?? true) ? 0 : 1
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionListData?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UMyCollectionCell.self)
        cell.data = ["pic_url": collectionListData![indexPath.item].goods_pic,
                     "name":collectionListData![indexPath.item].name,
                     "price":collectionListData![indexPath.item].price]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIGoodsDetailController()
        vc.goodsId = String(collectionListData![indexPath.item].goods_id)
        self.pushViewController(vc, animated: true)
    }
    
}
