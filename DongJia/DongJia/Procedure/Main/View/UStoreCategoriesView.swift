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
    let view = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 7
        $0.layer.masksToBounds = true
    }
    /// 综合排序
    let comprehensiveSort = UIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("综合", for: .normal)
        $0.setTitleColor(.theme, for: .selected)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }
    /// 销量排序
    let salesVolumeSort = QMUIButton().then{
        $0.backgroundColor = .white
        $0.setTitle("销量", for: .normal)
        $0.setTitleColor(.theme, for: .selected)
        $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
        $0.setImage(UIImage.init(named: "normol_sort"), for: .normal)
        $0.imagePosition = .right
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
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
        $0.isHidden = true
        $0.register(cellType: USuperBrandCell.self)
    }
    
    let layout = ZLCollectionViewVerticalLayout().then{
        $0.scrollDirection = .vertical //设置滚动方向
        $0.estimatedItemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.itemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.sectionInset = UIEdgeInsets.init(top: 15, left: 0, bottom: 15, right: 0)
        
        $0.canDrag = true
        $0.header_suspension = false
    }
    
    var storeListData: [String]?{
        didSet{
            storeListView.reloadData()
        }
    }
    
    /// 判断升降排序 升true 降false 未选中nil
    var upOrDown: Bool? {
        didSet{
            guard let isUp = upOrDown else {
                salesVolumeSort.isSelected = false
                return
            }
            salesVolumeSort.isSelected = true
            salesVolumeSort.setImage(UIImage.init(named: isUp ? "ascending_sort" : "descending_sort"), for: .selected)
        }
    }
    
    override func configUI() {
        
        
        self.backgroundColor = .theme
        self.addSubview(view)
        view.addSubview(comprehensiveSort)
        view.addSubview(salesVolumeSort)
        view.addSubview(latestSort)
        self.addSubview(storeListView)
        
        
        
        comprehensiveSort.addTarget(self, action: #selector(comprehensiveSortAction), for: .touchUpInside)
        salesVolumeSort.addTarget(self, action: #selector(salesVolumeSortAction), for: .touchUpInside)
        latestSort.addTarget(self, action: #selector(latestSortAction), for: .touchUpInside)
        
        layout.delegate = self
        storeListView.collectionViewLayout = layout
        storeListView.delegate = self
        storeListView.dataSource = self
        
        view.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
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
            make.width.bottom.equalToSuperview()
        }
        
    }
    
    // 综合排序点击
    @IBAction func comprehensiveSortAction(){
        comprehensiveSort.isSelected = true
        upOrDown = nil
        latestSort.isSelected = false
        showHUDInView(text: "综合排序点击", inView: topVC!.view, isClick: true)
    }
    // 销量排序点击
    @IBAction func salesVolumeSortAction(){
        comprehensiveSort.isSelected = false
        latestSort.isSelected = false
        if (upOrDown == nil) {
            upOrDown = true
        } else {
            upOrDown = !(upOrDown!)
        }
        showHUDInView(text: "销量排序点击", inView: topVC!.view, isClick: true)
    }
    // 最新排序点击
    @IBAction func latestSortAction(){
        comprehensiveSort.isSelected = false
        upOrDown = nil
        latestSort.isSelected = true
        showHUDInView(text: "最新排序点击", inView: topVC!.view, isClick: true)
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
