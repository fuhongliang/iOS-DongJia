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
    
    private let service = APIMainService()
    
    var cells: [MainItem] = [] {
        didSet{
            tableView.reloadData()
            tableView.layoutIfNeeded()
        }
    }
    
    /// 当前选择的城市
    var city: String!
    
    var bannerList:[banner_list]! //banner图列表
    var navIconList:[nav_icon_list]! // 分类导航列表
    var couponList:[coupon_list]!
    var limitedList:miaosha! //限时抢购列表
    var hotGoodsList:[recommend_goods]! //爆款热卖列表
    var superBrandList:[new_mch_list]! //超级品牌列表
    var featuredList:[featured_list] = [] //精选列表
    
    var currentPage = 1 // 当前精选的页数
    var pageCount = 0 // 精选的总页数
    /// 当前是否已经是精选列表的最大页数
    var isMaxPage: Bool{
        get {
            return currentPage >= pageCount
        }
    }
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = UIColor.background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.rowHeight = UITableView.automaticDimension
        $0.sectionFooterHeight = .leastNormalMagnitude
        $0.register(cellType: UMainSearchCell.self)
        $0.register(cellType: UMainBannerCell.self)
        $0.register(cellType: UMainClassificationCell.self)
        $0.register(cellType: UMainLimitedCell.self)
        $0.register(cellType: UMainHotCell.self)
        $0.register(cellType: UMainSuperBrandCell.self)
        $0.register(cellType: UMainFeaturedCell.self)
    }
    
    override func configUI() {
        self.tableView.uFoot = URefreshFooter { [weak self] in self?.getFeaturedData() }
        self.tableView.uempty = UEmptyView { [weak self] in self?.getMainData() }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        city = getCity()
        getMainData()
    }
    
    /// 从url中获取CatId
    func getCatId(_ url: String) -> String{
        let indexEqual = url.index(url.lastIndex(of: "=")!, offsetBy: 1)
        return String(url[indexEqual..<url.endIndex])
    }
    
    /// 获取首页数据
    func getMainData() {
        tableView.uempty?.allowShow = true
        service.getMainData(district: city, { (Model) in
            if Model.data == nil {
                showHUDInView(text: "没有数据", inView: self.view)
                return
            }
            self.currentPage = 1
            self.bannerList = Model.data?.banner_list
            self.navIconList = Model.data?.nav_icon_list
            self.limitedList = Model.data?.miaosha
            self.hotGoodsList = Model.data?.recommend_goods
            self.superBrandList = Model.data?.new_mch_list
            if (self.limitedList.goods_list?.isEmpty ?? true){
                self.cells = [.search, .banner, .classification, .hot, .superbrand]
            } else {
                self.cells = [.search, .banner, .classification, .limited, .hot, .superbrand]
            }
            self.getFeaturedData(true)
            
        }) { (APIErrorModel) in
            print(APIErrorModel.msg ?? "msg为空")
        }
    }
    
    /// 获取精选列表数据
    func getFeaturedData(_ isRefresh: Bool = false) {

        service.getMainFeaturedData(page: currentPage, { (Data) in
            if (isRefresh){
                self.featuredList = Data.data?.list ?? []
            } else {
                self.featuredList.append(contentsOf: Data.data?.list ?? [])
            }
            if (self.cells.count > 0 && self.currentPage == 1){
                self.cells.append(.featured)
            }
            self.currentPage += 1
            self.pageCount = Data.data?.page_count ?? 1
        }) { (APIErrorModel) in
            print(APIErrorModel.msg ?? "精选列表出错  错误信息:--")
        }
        if(isMaxPage) {
            tableView.uFoot.endRefreshingWithNoMoreData()
        } else {
            tableView.uFoot.endRefreshing()
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cells[indexPath.section]
        switch cellModel {
        case .search:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainSearchCell.self)
            cell.city = self.city
            cell.chooseCityAction = {
                let vc = UIChooseCityController()
                vc.title = "选择城市"
                self.pushViewController(vc, animated: true)
            }
            cell.searchAction = {
                let vc = UISearchController()
                vc.title = "搜索"
                self.pushViewController(vc, animated: true)
            }
            return cell
        case .banner:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainBannerCell.self)
            cell.urlArray = bannerList
            return cell
        case .classification:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainClassificationCell.self)
            cell.buildingMaterialsAction = {
                let vc = UIStoreAndGoodsCategoriesControllerViewController()
                vc.title = self.navIconList![0].name
                vc.cat_id = self.getCatId(self.navIconList![0].url)
                self.pushViewController(vc, animated: true)
            }
            cell.residentialFurnitureAction = {
                let vc = UIStoreAndGoodsCategoriesControllerViewController()
                vc.title = self.navIconList![1].name
                vc.cat_id = self.getCatId(self.navIconList![1].url)
                self.pushViewController(vc, animated: true)
            }
            cell.domesticInstallationAction = {
                let vc = UIStoreAndGoodsCategoriesControllerViewController()
                vc.title = self.navIconList![2].name
                vc.cat_id = self.getCatId(self.navIconList![2].url)
                self.pushViewController(vc, animated: true)
            }
            cell.householdAppliancesAction = {
                let vc = UIStoreAndGoodsCategoriesControllerViewController()
                vc.title = self.navIconList![3].name
                vc.cat_id = self.getCatId(self.navIconList![3].url)
                self.pushViewController(vc, animated: true)
            }
            cell.toViewMoreAction = {
                let vc = UIAllCategoriesController()
                vc.title = "全部分类"
                self.pushViewController(vc, animated: true)
            }
            return cell
        case .limited:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainLimitedCell.self)
            cell.limitedData = limitedList
            return cell
        case .hot:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainHotCell.self)
            cell.model = hotGoodsList
            return cell
        case .superbrand:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainSuperBrandCell.self)
            cell.model = superBrandList
            return cell
        case .featured:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UMainFeaturedCell.self)
            cell.model = featuredList
            return cell
        }
        
    }
    
}
