//
//  UIMainController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

enum MainItem {
    case search // 搜索栏
    case banner // banner图
    case classification //分类
    case limited // 显示抢购
    case hot // 爆款热卖
    case superbrand // 超级品牌
    case featured // 懂家臻选
}

class UIMainController: UBaseViewController {
    var mainView = UMainView()
    
    var cells: [MainItem] = [.search,
                             .banner,
                             .classification,
                             .limited,
                             .hot,
                             .superbrand,
                             .featured]
    
    var bannerUrl = [
        "http://ww1.sinaimg.cn/mw690/9bbc284bgw1f9rk86nq06j20fa0a4whs.jpg",
        "http://ww3.sinaimg.cn/mw690/9bbc284bgw1f9qg0bazmnj21hc0u0dop.jpg",
        "http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0nw7zbj20rs0jntk7.jpg",
        "http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg0utssrj20sg0hyx0o.jpg",
        "http://ww2.sinaimg.cn/mw690/9bbc284bgw1f9qg10w0w1j20s40jsah1.jpg"
    ]
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.frame = .zero
        $0.backgroundColor = UIColor.background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.register(cellType: UMainSearchCell.self)
        $0.register(cellType: UMainBannerCell.self)
        $0.register(cellType: UMainClassificationCell.self)
        $0.register(cellType: UMainLimitedCell.self)
        $0.register(cellType: UMainHotCell.self)
        $0.register(cellType: UMainSuperBrandCell.self)
        $0.register(cellType: UMainFeaturedCell.self)
    }
    
    override func configUI() {
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension UIMainController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK:返回cell的标题头
    func getHeaderTitle(viewForHeaderInSection section: Int) -> String?{
        let cellModel = cells[section]
        switch cellModel {
        case .limited:
            return "限时抢购"
        case .hot:
            return "爆款热卖"
        case .superbrand:
            return "超级品牌"
        case .featured:
            return "懂家臻选"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = getHeaderTitle(viewForHeaderInSection: section) else { return nil }
        
        let view = UIView(frame:CGRect(x: 0, y: 0, width: 100, height: 45))
        _ = UILabel().then{
            $0.frame = CGRect.init()
            $0.text = title
            $0.font = UIFont.boldSystemFont(ofSize: 17)
            $0.textColor = UIColor.black
            view.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(15)
                make.top.equalToSuperview().offset(20)
            })
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard getHeaderTitle(viewForHeaderInSection: section) != nil else { return CGFloat.leastNormalMagnitude }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cells[indexPath.section]
        switch cellModel {
        case .search:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainSearchCell.self)
            cell.chooseCityAction = {
                showHUDInView(text: "选择城市", inView: self.view)
            }
            cell.searchAction = {
                showHUDInView(text: "搜索", inView: self.view)
            }
            return cell
        case .banner:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainBannerCell.self)
            cell.urlArray = bannerUrl
            return cell
        case .classification:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainClassificationCell.self)
            cell.buildingMaterialsAction = {
                showHUDInView(text: "建材", inView: self.view)
            }
            cell.residentialFurnitureAction = {
                showHUDInView(text: "住宅家具", inView: self.view)
            }
            cell.domesticInstallationAction = {
                showHUDInView(text: "家政安装", inView: self.view)
            }
            cell.householdAppliancesAction = {
                showHUDInView(text: "家用电器", inView: self.view)
            }
            cell.toViewMoreAction = {
                showHUDInView(text: "查看更多", inView: self.view)
            }
            return cell
        case .limited:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainLimitedCell.self)
            return cell
        case .hot:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainHotCell.self)
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            
            cell.model = ["","","","","",""]
            
            return cell
        case .superbrand:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainSuperBrandCell.self)
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            
            cell.model = ["","",""]
            return cell
        case .featured:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainFeaturedCell.self)
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            
            cell.model = ["","",""]
            
            return cell
        }
        
    }
    
}
