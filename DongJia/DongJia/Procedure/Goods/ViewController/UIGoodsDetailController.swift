//
//  UIGoodsDetailController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/26.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

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

    let goodsDetailView = UGoodsDetailView()
    
    var cells: [GoodsDetailItem] = [] {
        didSet{
            goodsDetailView.tableView.reloadData()
        }
    }
    /// 当前WKWebView的高度
    var webHeight:CGFloat = 0
    var isLimited:Bool = false
    
    var isWebReload: Bool = false
    
    override func configUI() {
        goodsDetailView.tableView.delegate = self
        goodsDetailView.tableView.dataSource = self
        self.view.addSubview(goodsDetailView)
        goodsDetailView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        if isLimited {
            cells = [.picList,.limitedBuy,.nameService,.selectAttr,.storeInfo,.goodsDetail]
        } else {
            cells = [.picList,.ordinaryBuy,.nameService,.selectAttr,.storeInfo,.goodsDetail]
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
            cell.urlArray = [   "https://img10.360buyimg.com/babel/s1920x740_jfs/t1/41822/8/13956/141777/5d6dd412Eec49b050/0e76b5b4d984aa7a.jpg!cc_1920x740","https://img11.360buyimg.com/babel/s1920x740_jfs/t1/73049/14/8448/169664/5d673c4aE9c16467b/b6396b8314441e40.jpg!cc_1920x740","https://img12.360buyimg.com/babel/s1920x740_jfs/t1/45114/34/9119/125585/5d677e6fEb8c11d63/483c4df3ed453ea9.jpg!cc_1920x740","https://img13.360buyimg.com/babel/s1920x740_jfs/t1/53649/7/9460/173490/5d6dd404E9570219f/881570b962515f64.jpg!cc_1920x740","https://img14.360buyimg.com/babel/s1920x740_jfs/t1/46938/36/2882/54537/5d0a034dEf784851c/aa71610ec016159d.jpg!cc_1920x740","https://img20.360buyimg.com/babel/s1920x740_jfs/t1/67307/9/8957/301188/5d6dd429E8dd1478d/b8094c4aae7cb2b7.jpg!cc_1920x740"]
            return cell
        case .limitedBuy:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsLimitedBuyCell.self)
            return cell
        case .ordinaryBuy:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsOrdinaryBuyCell.self)
            return cell
        case .nameService:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsNameServiceCell.self)
            cell.serviceData = ["送货上门","免快递费"]
            return cell
        case .selectAttr:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsChooseAttrCell.self)
            return cell
        case .storeInfo:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsStoreInfoCell.self)
            cell.data = "00000"
            return cell
        case .goodsDetail:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UGoodsDetailWKWebViewCell.self)
//            self.currentIndex = indexPath
            cell.heightDelegate = self
            cell.html = "<p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/92/92a686cf756bedfc99a8c23bd71bd7c7484c49c8.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/3f/3f158c5f26a60f8338f9bb9c554c590af579c258.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/61/61404092294b85485d5e7a0557f3284778a8f5c7.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/5b/5b1d996a72eec10fd6420b4de9860348e45c9ece.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/63/636ccfa898b0f21699e4f9a0ab362f91299cb8e0.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/8c/8cf7fe3aebee06aaedc955e92bc3e9b1f9d2cd63.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/c8/c8f9fd73cc1251013372d6036d5ac617c060fce0.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/8e/8ec721c5582c2a129971ecbd5f5e8bd007437e51.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/5c/5c7db2c0f8446f1f7f876c185d40229a6b343deb.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/09/09a263f19838d8bafa509962633458ddd5e37062.jpg\"/></p><p><img src=\"http://yiwuyimei.oss-cn-beijing.aliyuncs.com/web/uploads/image/ac/ac95af64ed55485d7d077a2a04ee74af7d3ce6b2.jpg\"/></p><p><br/></p>"
//            cell.
            return cell
        }
    }
    
}

extension UIGoodsDetailController: UGoodsDetailWKWebViewHeightCallBack{
    
    func wkWebViewHeightCallBack(height: CGFloat) {
//        if !isWebReload {
//            self.goodsDetailView.tableView.reloadRows(at: [currentIndex], with: UITableView.RowAnimation.none)
//            isWebReload = true
//        } else {
            self.goodsDetailView.tableView.beginUpdates()
            self.goodsDetailView.tableView.endUpdates()
//        self.webHeight = height
//        }
    }
    
    
}
