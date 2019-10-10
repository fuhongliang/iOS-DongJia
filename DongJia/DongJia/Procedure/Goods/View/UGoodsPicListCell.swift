//
//  UGoodsPicListCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/27.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UGoodsPicListCell: UBaseTableViewCell {
    
    lazy var goodsPhotoView = ZKCycleScrollView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.isAutoScroll = false
        $0.register(cellClass: UPicCell.self)
        $0.currentPageIndicatorTintColor = .hex(hexString:"#0EC262")
        $0.pageIndicatorTintColor = .white
    }
    
    override func configUI() {
        
        //MARK:banner
        contentView.addSubview(goodsPhotoView)
        goodsPhotoView.snp.makeConstraints { (make) in
            make.top.bottom.width.equalToSuperview()
            make.height.equalTo(270)
        }
        goodsPhotoView.adjustWhenViewWillAppear()
    }
    
    var urlArray : [goods_detail_pic_list]? {
        didSet {
            guard urlArray != nil else { return }
            goodsPhotoView.reloadData()
        }
    }
    
}
extension UGoodsPicListCell: ZKCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: ZKCycleScrollView, didSelectItemAt indexPath: IndexPath) {
        showHUDInView(text: "第\(indexPath.item)张图", inView: topVC!.view, isClick: true)
    }
}
extension UGoodsPicListCell: ZKCycleScrollViewDataSource {
    func numberOfItems(in cycleScrollView: ZKCycleScrollView) -> Int {
        return urlArray?.count ?? 0
    }
    
    func cycleScrollView(_ cycleScrollView: ZKCycleScrollView, cellForItemAt indexPath: IndexPath) -> ZKCycleScrollViewCell {
        let cell = cycleScrollView.dequeueReusableCell(for: indexPath) as! UPicCell
        cell.imageUrl = urlArray![indexPath.item].pic_url
        return cell
    }
}
