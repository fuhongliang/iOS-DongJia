//
//  UIStoreController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/8.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

enum storeItem {
    /// 店铺信息
    case storeInfo
    /// 爆款推荐
    case hotRecommend
    /// 精品案例
    case classicCase
    /// 设计团队
    case designTeam
    /// 精选必买
    case willBuy
}

class UIStoreController: UBaseViewController {
    
    private let service = APIStoreService()
    
    let tableView = UITableView(frame: .zero, style: .grouped).then{
        $0.backgroundColor = .background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        
        $0.estimatedSectionFooterHeight = 0
        $0.register(cellType: UStoreMainInfoCell.self)
        $0.register(cellType: UStoreHotRecommendCell.self)
        $0.register(cellType: UStoreClassicCaseCell.self)
        $0.register(cellType: UStoreDesignTeamCell.self)
        $0.register(cellType: UStoreWillBuyCell.self)
    }
    
    var cellsHeightCache:[storeItem:CGFloat] = [:]
    
    var cells: [storeItem] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    /// 店家数据
    var storeInfoData: store_info_model?
    /// 店家精品案例
    var storeClassicCaseData: [store_classic_case_model]?
    /// 店铺ID
    var storeId: String = "0"

    override func configUI() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        getStoreInfo()
    }
    
    /// 获取商家主页数据
    func getStoreInfo(){
        if APIUser.shared.user?.access_token == nil {
            showHUDInView(text: "请先登录", inView: self.view)
            return
        }
        service.getStoreInfo(mchId: storeId, page: "1", { (StoreInfoData) in
            self.storeInfoData = StoreInfoData.data
            self.cells = [.storeInfo,.hotRecommend,.willBuy]
            
            //请求精品案例数据
            self.getStoreClassicCase()
        }) { (APIErrorModel) in
            
        }
    }
    /// 获取商家精品案例数据
    func getStoreClassicCase(){
        service.getStoreClassicCase(mchId: storeId, { (StoreClassicCaseData) in
            self.storeClassicCaseData = StoreClassicCaseData.data
            self.cells = [.storeInfo,.hotRecommend,.classicCase,.willBuy]
        }) { (APIErrorModel) in
            
        }
    }
    
    func getHeaderTitle(viewForHeaderInSection section: Int) -> String?{
        let index = cells[section]
        switch index {
        case .hotRecommend:
            return "爆款推荐"
        case .classicCase:
            return "精品案例"
        case .designTeam:
            return "设计团队"
        case .willBuy:
            return "精选必买"
        default:
            return nil
        }
    }
    
    /// 获取有头部cell的HeaderView
    /// title -> 左边的标题
    /// count -> 右边总数
    func getHeaderView(viewForHeaderInSection section: Int) -> UIView? {
        let index = cells[section]
        guard let title = getHeaderTitle(viewForHeaderInSection: section) else { return nil }
        let view = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 45))
        let titleLabel = UILabel().then{
            $0.text = title
            $0.font = UIFont.boldSystemFont(ofSize: 17)
            $0.textColor = UIColor.black
            view.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(15)
                make.top.equalToSuperview().offset(20)
            })
        }
        let btn = UIButton().then{
            $0.setImage(UIImage(named: "right_arrow"), for: .normal)
            $0.addTarget(self, action: #selector(countAction), for: .touchUpInside)
            $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 11)
        }
        switch index {
        case .classicCase:
            btn.setTitle("共\(12)个", for: .normal)
            view.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(-20)
                make.top.bottom.equalTo(titleLabel)
            })
            btn.setButtonShowType(.Left)
        case .designTeam:
            btn.setTitle("共\(24)人", for: .normal)
            view.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(-20)
                make.top.bottom.equalTo(titleLabel)
            })
            btn.setButtonShowType(.Left)
        case .hotRecommend,.willBuy:
            return view
        default:
            return nil
        }
        return view
    }
    
    @objc func countAction(){
        showHUDInView(text: "总数点击", inView: self.view, isClick: true)
    }

}
extension UIStoreController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getHeaderView(viewForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard getHeaderTitle(viewForHeaderInSection: section) != nil else { return 0 }
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellMode = cells[indexPath.section]
        switch cellMode {
        case .storeInfo:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreMainInfoCell.self)
            cell.moreInfoBtnAction = { (isOpen) in
                cell.brandInfo.numberOfLines = isOpen ? 0 : 3
                tableView.beginUpdates()
                tableView.endUpdates()
                // 开启修正偏移
                let currentOffset = tableView.contentOffset
                UIView.setAnimationsEnabled(false)
                tableView.setContentOffset(currentOffset, animated: false)
                UIView.setAnimationsEnabled(true)
            }
            cell.storeInfo = storeInfoData?.shop
            return cell
        case .hotRecommend:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreHotRecommendCell.self)
            cell.data = storeInfoData?.recommend_list
            return cell
        case .classicCase:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreClassicCaseCell.self)
            
            cell.data = storeClassicCaseData
            return cell
        case .designTeam:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreDesignTeamCell.self)
            cell.designerList = ["","","","","",""]
            return cell
        case .willBuy:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreWillBuyCell.self)
            
            cell.data = storeInfoData?.goods_list
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if (cells[indexPath.section] == .willBuy){
//            // 缓存精选必买的高度
//            if (cellsHeightCache[.willBuy] == nil){
//                cellsHeightCache[.willBuy] = CGFloat(storeInfoData!.goods_list.count * 230 / 2)
//            }
//            return cellsHeightCache[.willBuy]!
//        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        /// 这里给出估算高度(接近店铺信息cell的高度) 防止列表跳动问题
        return 280
    }
    
    
}
