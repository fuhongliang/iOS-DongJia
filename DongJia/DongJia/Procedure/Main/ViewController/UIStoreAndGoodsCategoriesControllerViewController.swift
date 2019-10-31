//
//  UIStoreAndGoodsCategoriesControllerViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/31.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import JXSegmentedView

class UIStoreAndGoodsCategoriesControllerViewController: UBaseViewController {

    let segmentedDataSource = JXSegmentedTitleDataSource()
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    let indicator = JXSegmentedIndicatorBackgroundView()
    let titles = ["商品","店铺"]
    
    override func configUI() {
        
        //配置数据源
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titles = titles
        segmentedDataSource.titleNormalColor = UIColor.hex(hexString: "#DEFFED")
        segmentedDataSource.titleSelectedColor = .white
        segmentedDataSource.isItemSpacingAverageEnabled = false
        segmentedDataSource.reloadData(selectedIndex: 0)
        
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = .lengthen
        indicator.indicatorColor = .white
        indicator.indicatorCornerRadius = 0
        indicator.indicatorHeight = 2
        
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.indicators = [indicator]
        segmentedView.delegate = self
        segmentedView.backgroundColor = .theme
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        view.addSubview(segmentedView)
        
        segmentedView.contentScrollView = listContainerView.scrollView
        view.addSubview(listContainerView)
        view.backgroundColor = .theme
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationBar(barStyle: .theme)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        listContainerView.frame = CGRect(x: 0, y: 60, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }
    

}

extension UIStoreAndGoodsCategoriesControllerViewController: JXSegmentedViewDelegate{
    
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
}

extension UIStoreAndGoodsCategoriesControllerViewController: JXSegmentedListContainerViewDataSource{
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if (index == 0){
            return UGoodsCategoriesView()
        }
        return UStoreCategoriesView()
    }
    
    
}
