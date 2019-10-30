//
//  UISearchController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UISearchController: UBaseViewController {
    
    private let service = APIMainService()
    
    let searchView = USearchView()
    
    var currentPage: Int = 1
    
    var pageCount: Int = 1
    
    /// 当前是否已经是精选列表的最大页数
    var isMaxPage: Bool{
        get {
            return currentPage >= pageCount
        }
    }
    
    var searchData: [search_goods_model]? {
        didSet{
            guard searchData != nil else { return }
            searchView.searchHistoryView.isHidden = false
            searchView.searchHistoryView.reloadData()
        }
    }
    
    var searchHistory: [String]!
    
    override func configUI() {
        view.addSubview(searchView)
        searchView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        searchView.delegate = self
        searchView.searchHistoryView.delegate = self
        searchView.searchHistoryView.dataSource = self
        
        searchHistory = UserDefaults.standard.stringArray(forKey: "Search_History") ?? []
        searchView.history = searchHistory
        
    }
    
    /// 获取搜索历史
    func getSearchHistory(keyword: String){
        service.searchGoodsList(keyWord: keyword, page: currentPage, { (SearchGoods) in
            if self.currentPage == 1 {
                self.searchData = SearchGoods.data.list
            } else {
                self.searchData?.append(contentsOf: SearchGoods.data.list)
            }
            
            self.currentPage += 1
            self.pageCount = SearchGoods.data.page_count
            if (self.isMaxPage) {
                self.searchView.searchHistoryView.uFoot.endRefreshingWithNoMoreData()
            } else {
                self.searchView.searchHistoryView.uFoot.endRefreshing()
            }
        }) { (APIErrorModel) in
            
        }
    }

}
extension UISearchController: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return searchData == nil ? 0 : 1
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UMyCollectionCell.self)
        cell.data = ["pic_url": searchData![indexPath.item].pic_url,
                     "price": searchData![indexPath.item].price,
                     "name": searchData![indexPath.item].name]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIGoodsDetailController()
        vc.goodsId = (self.searchData?[indexPath.item].id)!
        vc.storeId = (self.searchData?[indexPath.item].store_id)!
        self.pushViewController(vc, animated: true)
    }
    
}
extension UISearchController: USearchViewDelegate{
    
    func loadMore(){
        getSearchHistory(keyword: searchView.searchTf.text!)
    }
    
    func clearHistory(index: Int) {
        if index == -1 {
            searchHistory.removeAll()
        } else {
            searchHistory.remove(at: index)
        }
        searchView.history = searchHistory
        UserDefaults.standard.set(searchHistory, forKey: "Search_History")
    }
    
    func searchGoods(keyWord: String?) {
        currentPage = 1
        if (keyWord == nil) { return }
        for item in searchHistory{
            if (item == keyWord!){
                searchHistory.remove(at: searchHistory.firstIndex(of: item)!)
                break
            }
        }
        if keyWord != "" {
            searchHistory.insert(keyWord!, at: 0)
        }
        UserDefaults.standard.set(searchHistory, forKey: "Search_History")
        getSearchHistory(keyword: keyWord!)
    }
    
    func clearSearch() {
        currentPage = 1
        searchView.searchHistoryView.isHidden = true
        searchView.history = searchHistory
    }
    
    
}
