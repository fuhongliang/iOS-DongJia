//
//  UIGoodsDetailController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/26.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import MBProgressHUD

enum GoodsDetailItem {
    /// 图片列表
    case picList
    /// 限时购买(价格和时间)
    case limitedBuy
    /// 不是限时购买(价格和购买信息)
    case ordinaryBuy
    /// 商品名称和服务事项
    case nameService
    /// 选择商品的规格
    case selectAttr
    /// 店铺信息和店铺推荐商品
    case storeInfo
    /// 商品详情
    case goodsDetail
}

class UIGoodsDetailController: UBaseViewController {
    
    private let service = APIGoodsService()

    let goodsDetailView = UGoodsDetailView()
    /// 请求的商品数据
    var goodsData: APIGoodsDetailModel!
    /// 请求的商品推荐数据
    var goodsRecommendData: goods_recommend_model?
    
    /// 当前页面是否是限时抢购的商品
    var isLimited:Bool = false
    /// 店铺ID
    var storeId = "4"
    /// 商品ID
    var goodsId = "-1"
    
    var cells: [GoodsDetailItem] = []
//    {
//        didSet{ goodsDetailView.tableView.reloadData() }
//    }
    
    /// 当前所有请求是否都已完成
    var requestComplete: Int = 0 {
        didSet{
            if(requestComplete == 2){
                goodsDetailView.tableView.reloadData()
            }
        }
    }
    
    override func configUI() {
        goodsDetailView.tableView.delegate = self
        goodsDetailView.tableView.dataSource = self
        self.view.addSubview(goodsDetailView)
        goodsDetailView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        getGoodsDetailData()
        getGoodsRecommend()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// 请求商品详情数据
    func getGoodsDetailData() {
        service.getGoodsDetail(storeId: storeId, goodsId: goodsId, { (GoodsDetailModel) in
            guard let goodsData = GoodsDetailModel.data else { return }
            self.goodsData = goodsData
            if self.isLimited {
                self.cells = [.picList,.limitedBuy,.nameService,.selectAttr,.storeInfo,.goodsDetail]
            } else {
                self.cells = [.picList,.ordinaryBuy,.nameService,.selectAttr,.storeInfo,.goodsDetail]
            }
            self.requestComplete += 1
        }) { (APIErrorModel) in
            showHUDInView(text: APIErrorModel.msg ?? "", inView: self.view)
        }
    }
    
    /// 请求该商品下的商品爆款推荐
    func getGoodsRecommend(){
        service.getGoodsRecommend(goodsId: goodsId, { (GoodsRecommendModel) in
            guard let goodsRecommendData = GoodsRecommendModel.data else { return }
            self.goodsRecommendData = goodsRecommendData
            self.requestComplete += 1
        }) { (APIErrorModel) in
            self.requestComplete += 1
            print(APIErrorModel.msg ?? "")
        }
    }
    
}

extension UIGoodsDetailController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK:返回cell的标题头
    func getIsHaveHeader(viewForHeaderInSection section: Int) -> Bool{
        let cellModel = cells[section]
        switch cellModel {
        case .selectAttr:
            return true
        case .storeInfo:
            return true
        case .goodsDetail:
            return true
        default:
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard getIsHaveHeader(viewForHeaderInSection: section) else { return CGFloat.leastNormalMagnitude }
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cells[indexPath.section]
        switch cellModel {
        case .picList:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsPicListCell.self)
            cell.urlArray = goodsData?.pic_list
            return cell
        case .limitedBuy:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsLimitedBuyCell.self)
            return cell
        case .ordinaryBuy:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsOrdinaryBuyCell.self)
            return cell
        case .nameService:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsNameServiceCell.self)
            cell.name = goodsData.name
            cell.serviceData = goodsData.service_list
            return cell
        case .selectAttr:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsChooseAttrCell.self)
            return cell
        case .storeInfo:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsStoreInfoCell.self)
            cell.mchData = goodsData.mch
            cell.recommendData = goodsRecommendData?.list
            cell.enterStoreAction = {
                let vc = UIStoreController()
                vc.title = "店铺详情"
                vc.storeId = "\(self.goodsData.mch.id)"
                self.pushViewController(vc, animated: true)
            }
            return cell
        case .goodsDetail:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsDetailWKWebViewCell.self)
            cell.heightDelegate = self
            cell.html = goodsData.detail
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (cells[indexPath.section] == .selectAttr){
            let vc = UIChooseAttrViewController()
            self.definesPresentationContext = true
            vc.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            self.present(vc, animated: true)
            
        }
    }
}

extension UIGoodsDetailController: UGoodsDetailWKWebViewHeightCallBack{
    
    func wkWebViewHeightCallBack(height: CGFloat) {
        // 刷新tableView的frame
        self.goodsDetailView.tableView.beginUpdates()
        self.goodsDetailView.tableView.endUpdates()
        // 取消loading显示
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}
