//
//  UStoreCategoriesView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/31.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit
import JXSegmentedView
import ZLCollectionViewFlowLayout

class UStoreCategoriesView: BaseView {
    
    private var service = APIMainService()
    
    private var cat_id: String = ""
    
    var currentPage = 1 // 当前精选的页数
    var pageCount = 0 // 精选的总页数
    /// 当前是否已经是精选列表的最大页数
    var isMaxPage: Bool{
        get {
            return currentPage >= pageCount
        }
    }
    
    /// 综合排序
    let comprehensiveSort = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("综合", for: .normal)
        $0.setTitleColor(.theme, for: .selected)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.isSelected = true
    }
    /// 销量排序
    let salesVolumeSort = QMUIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("销量", for: .normal)
        $0.setTitleColor(.theme, for: .selected)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    /// 最新排序
    let latestSort = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("最新", for: .normal)
        $0.setTitleColor(.theme, for: .selected)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    var storeListView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.register(cellType: USuperBrandCell.self)
    }
    
    let layout = ZLCollectionViewVerticalLayout().then{
        $0.estimatedItemSize = CGSize(width: screenWidth-30, height: 202)//设置cell的大小
        $0.itemSize = CGSize(width: screenWidth-30, height: 202)//设置cell的大小
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        
        $0.canDrag = true
        $0.header_suspension = false
    }
    
    var storeListData: [cat_mch_list_model]?{
        didSet{
            guard storeListData != nil else { return }
            storeListView.uempty?.allowShow = true
            storeListView.reloadData()
        }
    }
    
    init(catId: String) {
        cat_id = catId
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configUI() {
        
        self.addSubview(comprehensiveSort)
        self.addSubview(salesVolumeSort)
        self.addSubview(latestSort)
        self.addSubview(storeListView)
        
        comprehensiveSort.addTarget(self, action: #selector(comprehensiveSortAction), for: .touchUpInside)
        salesVolumeSort.addTarget(self, action: #selector(salesVolumeSortAction), for: .touchUpInside)
        latestSort.addTarget(self, action: #selector(latestSortAction), for: .touchUpInside)
        
        layout.delegate = self
        storeListView.collectionViewLayout = layout
        storeListView.delegate = self
        storeListView.dataSource = self
        storeListView.uFoot = URefreshFooter { [weak self] in self?.getCatStoreList() }
        storeListView.uempty = UEmptyView { [weak self] in self?.getCatStoreList() }
        
        //MARK:综合排序
        comprehensiveSort.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: screenWidth/3, height: 42))
            make.left.top.equalToSuperview()
        }
        
        //MARK:销量排序
        salesVolumeSort.snp.makeConstraints { (make) in
            make.size.equalTo(comprehensiveSort)
            make.top.equalToSuperview()
            make.left.equalTo(comprehensiveSort.snp.right)
        }
        
        //MARK:最新排序
        latestSort.snp.makeConstraints { (make) in
            make.size.equalTo(comprehensiveSort)
            make.top.equalToSuperview()
            make.left.equalTo(salesVolumeSort.snp.right)
        }
        
        //MARK:店铺列表
        storeListView.snp.makeConstraints { (make) in
            make.top.equalTo(salesVolumeSort.snp.bottom)
            make.width.left.bottom.equalToSuperview()
            make.height.equalTo(42)
        }
        
        getCatStoreList()
        
    }
    
    /// 获取该分类下的商家列表
    func getCatStoreList(){
        var sort = 0
        if (comprehensiveSort.isSelected){
            sort = 1
        } else if (latestSort.isSelected){
            sort = 3
        } else {
            sort = 2
        }
        
        service.catMchList(district: getCity(), cat_id: cat_id, sort: sort, page: currentPage, { (CatStoreList) in
            self.pageCount = CatStoreList.data.page_count
            
            if (self.currentPage == 1){
                self.storeListData = CatStoreList.data.list
            } else {
                self.storeListData?.append(contentsOf: CatStoreList.data.list)
            }
            if (self.isMaxPage) {
                self.storeListView.uFoot.endRefreshingWithNoMoreData()
            } else {
                self.currentPage += 1
                self.storeListView.uFoot.endRefreshing()
            }
        }) { (APIErrorModel) in
            
        }
    }
    
    // 综合排序点击
    @IBAction func comprehensiveSortAction(){
        comprehensiveSort.isSelected = true
        salesVolumeSort.isSelected = false
        latestSort.isSelected = false
        currentPage = 1
        getCatStoreList()
    }
    // 销量排序点击
    @IBAction func salesVolumeSortAction(){
        comprehensiveSort.isSelected = false
        salesVolumeSort.isSelected = true
        latestSort.isSelected = false
        currentPage = 1
        getCatStoreList()
    }
    // 最新排序点击
    @IBAction func latestSortAction(){
        comprehensiveSort.isSelected = false
        salesVolumeSort.isSelected = false
        latestSort.isSelected = true
        currentPage = 1
        getCatStoreList()
    }

}

extension UStoreCategoriesView: JXSegmentedListContainerViewListDelegate{
    func listView() -> UIView {
        return self
    }
}

extension UStoreCategoriesView: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return storeListData == nil ? 0 : 1
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storeListData?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: USuperBrandCell.self)
        cell.catStoreData = storeListData![indexPath.item]
        
        cell.goods1Action = {
            //商品详情跳转
            let vc = UIGoodsDetailController()
            vc.goodsId = self.storeListData![indexPath.item].goods_list[0].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.goods2Action = {
            //商品详情跳转
            let vc = UIGoodsDetailController()
            vc.goodsId = self.storeListData![indexPath.item].goods_list[1].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.goods3Action = {
            //商品详情跳转
            let vc = UIGoodsDetailController()
            vc.goodsId = self.storeListData![indexPath.item].goods_list[2].id
            topVC?.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoreController()
        vc.storeId = "4"
        topVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension UStoreCategoriesView: ZLCollectionViewBaseFlowLayoutDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
        return ClosedLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, columnCountOfSection section: Int) -> Int {
        return 1
    }
    
}
