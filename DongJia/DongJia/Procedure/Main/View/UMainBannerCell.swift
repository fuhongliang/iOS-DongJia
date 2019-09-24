//
//  UMainBannerCell.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UMainBannerCell: UBaseTableViewCell {
    
    
    lazy var bannerView = ZKCycleScrollView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.autoScrollDuration = 5.0
        $0.register(cellClass: UBannerImageCell.self)
    }
    
    
    override func configUI() {

        contentView.backgroundColor = UIColor.background
        //MARK:banner
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalToSuperview().inset(15)
            make.height.equalTo(160)
        }
        bannerView.adjustWhenViewWillAppear()
    }
    
    var urlArray : [banner_list]? {
        didSet {
            guard urlArray != nil else { return }
            bannerView.reloadData()
        }
    }

}
extension UMainBannerCell: ZKCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: ZKCycleScrollView, didSelectItemAt indexPath: IndexPath) {
        print("点击了：\(indexPath.item)")
    }
    
}
extension UMainBannerCell: ZKCycleScrollViewDataSource {
    func numberOfItems(in cycleScrollView: ZKCycleScrollView) -> Int {
        return urlArray?.count ?? 0
    }
    
    func cycleScrollView(_ cycleScrollView: ZKCycleScrollView, cellForItemAt indexPath: IndexPath) -> ZKCycleScrollViewCell {
        let cell = cycleScrollView.dequeueReusableCell(for: indexPath) as! UBannerImageCell
        cell.imageUrl = urlArray![indexPath.item].pic_url
        return cell
    }
}
