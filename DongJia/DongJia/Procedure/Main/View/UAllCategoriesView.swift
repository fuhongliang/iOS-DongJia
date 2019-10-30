//
//  UAllCategoriesView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/30.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import ZLCollectionViewFlowLayout

protocol UAllCategoriesViewDelegate {
    /// 一级分类点击
    func primaryClassificationClick()
    /// 二级分类点击
    func secondaryClassificationClick()
}

class UAllCategoriesView: BaseView {
    
    var delegate: UAllCategoriesViewDelegate?

    /// 一级分类列表
    let primaryTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = UIColor.background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = 48
        $0.register(cellType: UPrimaryClassificationCell.self)
    }
    
    /// 二级分类列表
    let secondartCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
        $0.bounces = true
        $0.allowsMultipleSelection = true
        $0.register(cellType: USecondartClassificationCell.self)
    }
    
    // 创建一个有多布局的layout
    let flowLayout = ZLCollectionViewVerticalLayout().then{
        $0.itemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.sectionInset = UIEdgeInsets.init(top: 15, left: 0, bottom: 15, right: 0)
        
        $0.canDrag = true
        $0.header_suspension = false
    }
    
    override func configUI() {
        primaryTableView.delegate = self
        primaryTableView.dataSource = self
        primaryList = ["123","dsa","eqr","vcxz","ddss","aadd","bbff"]
        self.addSubview(primaryTableView)
        self.addSubview(secondartCollectionView)
        flowLayout.delegate = self
        secondartCollectionView.collectionViewLayout = flowLayout
        
        //MARK:一级列表
        primaryTableView.snp.makeConstraints { (make) in
            make.height.left.top.equalToSuperview()
            make.width.equalTo(84)
        }
        
        //MARK:二级列表
        secondartCollectionView.snp.makeConstraints { (make) in
            make.top.right.height.equalToSuperview()
            make.left.equalTo(primaryTableView.snp.right)
        }
    }
    
    var primaryList: [String]?{
        didSet{
            guard primaryList != nil else { return }
            primaryTableView.reloadData()
        }
    }
    
    var secondartList: [String]?{
        didSet{
            guard secondartList != nil else { return }
            secondartCollectionView.reloadData()
        }
    }
    
    var selectPrimary: Int = 0

}

extension UAllCategoriesView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secondartList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: USecondartClassificationCell.self)
        cell.classificationData = "瓷砖"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.secondaryClassificationClick()
    }
    
}

extension UAllCategoriesView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return primaryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UPrimaryClassificationCell.self)
        cell.name = primaryList![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectPrimary = indexPath.row
        for item in 0 ..< primaryList!.count{
            let cell = tableView.cellForRow(at: IndexPath(row: item, section: 0))
            cell!.setSelected(item == selectPrimary, animated: true)
        }
        delegate?.primaryClassificationClick()
    }
    
}

extension UAllCategoriesView: ZLCollectionViewBaseFlowLayoutDelegate{
    
    // 返回当前的布局类型
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
        return ClosedLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, columnCountOfSection section: Int) -> Int {
        return 3
    }
}
