//
//  UGoodsCategoriesView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/31.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit
import JXSegmentedView
import ZLCollectionViewFlowLayout

class UGoodsCategoriesView: BaseView {
    
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
    /// 价格排序
    let priceSort = QMUIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("价格", for: .normal)
        $0.setTitleColor(.theme, for: .selected)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.setImage(UIImage.init(named: "normol_sort"), for: .normal)
        $0.imagePosition = .right
    }
    /// 销量排序
    let salesVolumeSort = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("销量", for: .normal)
        $0.setTitleColor(.theme, for: .selected)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    
    var goodsListView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.register(cellType: UMyCollectionCell.self)
    }
    
    let layout = ZLCollectionViewVerticalLayout().then{
        $0.estimatedItemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.itemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.sectionInset = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15)
        
        $0.canDrag = true
        $0.header_suspension = false
    }
    
    var goodsListData: [cat_goods_list_model]?{
        didSet{
            guard goodsListData != nil else { return }
            goodsListView.uempty?.allowShow = true
            goodsListView.reloadData()
        }
    }
    
    /// 判断升降排序 升true 降false 未选中nil
    var upOrDown: Bool? {
        didSet{
            guard let isUp = upOrDown else {
                priceSort.isSelected = false
                return
            }
            priceSort.isSelected = true
            priceSort.setImage(UIImage.init(named: isUp ? "ascending_sort" : "descending_sort"), for: .selected)
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
        self.addSubview(priceSort)
        self.addSubview(salesVolumeSort)
        self.addSubview(goodsListView)
        
        comprehensiveSort.addTarget(self, action: #selector(comprehensiveSortAction), for: .touchUpInside)
        priceSort.addTarget(self, action: #selector(priceSortAction), for: .touchUpInside)
        salesVolumeSort.addTarget(self, action: #selector(salesVolumeSortAction), for: .touchUpInside)
        
        layout.delegate = self
        goodsListView.collectionViewLayout = layout
        goodsListView.delegate = self
        goodsListView.dataSource = self
        goodsListView.uFoot = URefreshFooter { [weak self] in self?.getCatGoodsList() }
        goodsListView.uempty = UEmptyView { [weak self] in self?.getCatGoodsList() }
        
        //MARK:综合排序
        comprehensiveSort.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: screenWidth/3, height: 42))
            make.left.top.equalToSuperview()
        }
        
        //MARK:价格排序
        priceSort.snp.makeConstraints { (make) in
            make.size.equalTo(comprehensiveSort)
            make.top.equalToSuperview()
            make.left.equalTo(comprehensiveSort.snp.right)
        }
        
        //MARK:销量排序
        salesVolumeSort.snp.makeConstraints { (make) in
            make.size.equalTo(comprehensiveSort)
            make.top.equalToSuperview()
            make.left.equalTo(priceSort.snp.right)
        }
        
        //MARK:店铺列表
        goodsListView.snp.makeConstraints { (make) in
            make.top.equalTo(priceSort.snp.bottom)
            make.width.left.bottom.equalToSuperview()
            make.height.equalTo(42)
        }
        
        getCatGoodsList()
        
    }
    
    /// 获取该分类下的商品列表
    func getCatGoodsList(){
        var sort = 0
        var sortType = 0
        if (comprehensiveSort.isSelected){
            sort = 0
        } else if (salesVolumeSort.isSelected){
            sort = 2
        } else {
            sort = 1
            if(upOrDown!){
                sortType = 0
            } else {
                sortType = 1
            }
        }
        
        service.catGoodsList(district: getCity(), cat_id: cat_id, page: currentPage, sort: sort, sort_type: sortType, { (CatGoodsList) in
            self.pageCount = CatGoodsList.data.page_count
            if (self.currentPage == 1){
                self.goodsListData = CatGoodsList.data.list
            } else {
                self.goodsListData!.append(contentsOf: CatGoodsList.data.list)
            }
            if (self.isMaxPage) {
                self.goodsListView.uFoot.endRefreshingWithNoMoreData()
            } else {
                self.currentPage += 1
                self.goodsListView.uFoot.endRefreshing()
            }
        }) { (APIErrorModel) in
            
        }
    }
    
    // 综合排序点击
    @IBAction func comprehensiveSortAction(){
        comprehensiveSort.isSelected = true
        upOrDown = nil
        salesVolumeSort.isSelected = false
        currentPage = 1
        getCatGoodsList()
    }
    // 价格排序点击
    @IBAction func priceSortAction(){
        comprehensiveSort.isSelected = false
        salesVolumeSort.isSelected = false
        if (upOrDown == nil) {
            upOrDown = true
        } else {
            upOrDown = !(upOrDown!)
        }
        currentPage = 1
        getCatGoodsList()
    }
    // 销量排序点击
    @IBAction func salesVolumeSortAction(){
        comprehensiveSort.isSelected = false
        upOrDown = nil
        salesVolumeSort.isSelected = true
        currentPage = 1
        getCatGoodsList()
    }
    
}

extension UGoodsCategoriesView: JXSegmentedListContainerViewListDelegate{
    func listView() -> UIView {
        return self
    }
}

extension UGoodsCategoriesView: UICollectionViewDelegate, UICollectionViewDataSource{
    //MARK:section数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return goodsListData == nil ? 0 : 1
    }
    
    //MARK:每个section有多少Item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodsListData?.count ?? 0
    }
    
    //MARK:返回每个Item的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UMyCollectionCell.self)
        cell.data = ["pic_url": goodsListData![indexPath.item].pic_url,
                     "name":goodsListData![indexPath.item].name,
                     "price":goodsListData![indexPath.item].price,
                     "origin_price":goodsListData![indexPath.item].original_price,
                     "buy_num":goodsListData![indexPath.item].virtual_sales]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIGoodsDetailController()
        vc.goodsId = goodsListData![indexPath.item].id
        topVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension UGoodsCategoriesView: ZLCollectionViewBaseFlowLayoutDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
        return ClosedLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, columnCountOfSection section: Int) -> Int {
        return 2
    }
    
}
