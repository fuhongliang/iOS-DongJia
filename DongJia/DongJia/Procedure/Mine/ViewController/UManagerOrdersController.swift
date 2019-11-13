//
//  UManagerOrdersController.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/6/24.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import JXSegmentedView

class UManagerOrdersController: UBaseViewController {
    var segmentedDataSource = JXSegmentedTitleDataSource()
    var segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    let indicator = JXSegmentedIndicatorBackgroundView()
    let titles = ["全部","待付款", "待发货", "待收货", "已完成", "已取消"]
    
    let totalItemWidth: CGFloat = 150
    
    override func configUI() {
        //配置数据源
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titles = titles
        segmentedDataSource.titleNormalColor = UIColor.hex(hexString: "#666666")
        segmentedDataSource.titleSelectedColor = .black
        segmentedDataSource.isItemSpacingAverageEnabled = false
        segmentedDataSource.reloadData(selectedIndex: 0)
        
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.lineStyle = .lengthen
        indicator.indicatorColor = .theme
        indicator.indicatorCornerRadius = 0
        indicator.indicatorHeight = 2
        
        //segmentedViewDataSource一定要通过属性强持有！！！
        segmentedView.dataSource = segmentedDataSource
        segmentedView.indicators = [indicator]
        segmentedView.delegate = self
        segmentedView.backgroundColor = .white
        segmentedView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 50)
        view.addSubview(segmentedView)
        
        segmentedView.contentScrollView = listContainerView.scrollView
        view.addSubview(listContainerView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        segmentedView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        listContainerView.frame = CGRect(x: 0, y: 44, width: screenWidth, height: view.bounds.size.height-44)
    }
    
}

extension UManagerOrdersController : JXSegmentedViewDelegate,JXSegmentedListContainerViewDataSource {
    
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = UOrderListController()
        
        switch index {
        case 0:
            vc.orderType = OrderType.All
        case 1:
            vc.orderType = OrderType.NotPay
        case 2:
            vc.orderType = OrderType.NotReceipt
        case 3:
            vc.orderType = OrderType.NotObtain
        case 4:
            vc.orderType = OrderType.Complete
        case 5:
            vc.orderType = OrderType.Cancle
        default:
            vc.orderType = OrderType.All
        }
        
        return vc
        
    }
    
}
