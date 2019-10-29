//
//  UShopCartViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UShopCartViewController: UBaseViewController {
    
    private let service = APIGoodsService()
    
    let shopCartView = UShopCartView()
    
    var allPrice: Double = 0 {
        didSet{
            self.shopCartView.setPrice(allPrice)
        }
    }
    
    /// 购物车列表数据
    var cartListData: shop_cart_list_model?
    
    /// 保存购物车选中状态
    var isCheckArray:[[Bool]] = [[Bool]](){
        didSet{
            // 存储当前的选中商品的价格
            var price: Double = 0
            // 用来判断当前是否全部选择了列表中的数据
            // 初始值为true 表示为只要设置了false后面就直接判断为没有全选
            var isCheckAll = true
            // 遍历每个的值
            for (section, item) in isCheckArray.enumerated(){
                for (row, choose) in item.enumerated() {
                    if (choose) {
                        // 用于临时计算当前item的价格
                        var p: Double = 0
                        if (section==0 && !(cartListData?.list ?? []).isEmpty){
                            // 有平台自营商品 先取自营商品的价格
                            p = Double(cartListData?.list[row].num ?? 0) * (cartListData?.list[row].price ?? 0.0)
                        } else if(!(cartListData?.list ?? []).isEmpty){
                            // 有平台自营商品 则section-1取商家商品列表中的数据
                            p = Double(cartListData?.mch_list[section-1].list[row].num ?? 0) * (cartListData?.mch_list[section-1].list[row].price ?? 0.0)
                        } else {
                            // 没有平台自营商品 正常取值商家商品列表
                            p = Double(cartListData?.mch_list[section].list[row].num ?? 0) * (cartListData?.mch_list[section].list[row].price ?? 0.0)
                        }
                        price += p
                    }
                    
                    // 判断是否全选的状态
                    // 如果有一个没选中 就不是全选
                    if (isCheckAll && !choose) {
                        isCheckAll = false
                    }
                }
            }
            // 计算完毕后显示总价格
            print(price.roundTo(places: 2))
            allPrice = price.roundTo(places: 2)
            // 全选状态
            shopCartView.selectAllBtn.isSelected = isCheckAll
        }
    }
    
    override func configUI() {
        
        shopCartView.delegate = self
        shopCartView.tableView.delegate = self
        shopCartView.tableView.dataSource = self
        
        view.addSubview(shopCartView)
        shopCartView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartListData()
    }
    
    /// 获取购物车数据
    func getCartListData(){
        if (!isLogin) {
            showHUDInView(text: "请先登录", inView: self.view, isClick: true)
            return
        }
        service.getCartGoodsList({ (Data) in
            self.isCheckArray.removeAll()
            self.cartListData = Data.data
            if !(self.cartListData?.list ?? []).isEmpty {
                // 拼接平台自营商品列表
                self.isCheckArray.append([Bool]())
                for _ in self.cartListData!.list{
                    self.isCheckArray[0].append(false)
                }
            }
            // 拼接商家商品列表
            for (index,item) in (self.cartListData?.mch_list ?? []).enumerated(){
                self.isCheckArray.append([Bool]())
                for _ in item.list{
                    self.isCheckArray[index].append(false)
                }
            }
            self.shopCartView.tableView.uHead.endRefreshing()
            self.shopCartView.reloadData()
        }) { (APIErrorModel) in
            
        }
    }
    
    /// 编辑购物车商品
    func editCartGoods(id: String, number: String){
        let cartIdList = [["cart_id": id, "num": number]]
        service.editCartGoods(cart_id_list: toJson(cartIdList), { (APIObjectModel) in
            print("商品数量 修改成功---\(APIObjectModel.msg!)")
        }) { (APIErrorModel) in
            
        }
    }
    /// 删除购物车商品
    func deleteCartGoods(idArray:[Int]){
        service.deleteCartGoods(cart_id_list: "\(idArray)", { (APIObjectModel) in
            showHUDInView(text: APIObjectModel.msg ?? "", inView: self.view, isClick: true)
            // 删除成功后重新请求列表数据
            self.getCartListData()
        }) { (APIErrorModel) in
            
        }
    }
    
    /// 获取选中的商品ID或购物车ID  isNeedCartId true->购物车ID false->商品ID
    func getSelectGoodsId(isNeedCartId: Bool) -> [Int] {
        var selectGoods = [Int]()
        for (section, item) in isCheckArray.enumerated() {
            for (row, choose) in item.enumerated(){
                if (choose) {
                    var id = 0
                    if (section==0 && !(cartListData?.list ?? []).isEmpty){
                        id = isNeedCartId ? cartListData!.list[row].cart_id : cartListData!.list[row].goods_id
                    } else if(!(cartListData?.list ?? []).isEmpty){
                       id = isNeedCartId ? cartListData!.mch_list[section-1].list[row].cart_id : cartListData!.mch_list[section-1].list[row].goods_id
                    } else {
                       id = isNeedCartId ? cartListData!.mch_list[section].list[row].cart_id : cartListData!.mch_list[section].list[row].goods_id
                    }
                    selectGoods.append(id)
                }
            }
        }
        return selectGoods
    }
    
    /// 生成到结算页的需要的Json数据
    func generateMchListJson() -> String{
        
        var mch_list = [Dictionary<String,Any>]()
        for (section, item) in isCheckArray.enumerated(){
            var mch:[String:Any] = [:]
            // 当前商家的商品是否有选中
            var isHaveSection = false
            var cart_id_list = [Int]()
            for (row, choose) in item.enumerated(){
                if choose {
                    isHaveSection = true
                    cart_id_list.append(self.cartListData!.mch_list[section].list[row].cart_id)
                }
            }
            if (isHaveSection){
                mch["id"] = self.cartListData!.mch_list[section].id
                mch["cart_id_list"] = cart_id_list
                mch_list.append(mch)
            }
        }
        return toJson(mch_list)
        
    }
    
}

extension UShopCartViewController: ShopCartDelegate{
    func refreshShopCartList() {
        getCartListData()
    }
    
    func loadMoreShopCartList() {
        // 暂时不考虑购物车分页 后台会一次性返回所有购物车商品
    }
    
    // 删除商品
    func deleteGoods() {
        deleteCartGoods(idArray: getSelectGoodsId(isNeedCartId: true))
    }
    // 结算
    func buy() {
        if (getSelectGoodsId(isNeedCartId: true).isEmpty) {
            showHUDInView(text: "请先选择商品", inView: self.view, isClick: true)
            return
        }
        let vc = UIConfirmOrderController()
        vc.title = "确认订单"
        
        vc.mch_list = generateMchListJson()
        vc.cart_id_list = getSelectGoodsId(isNeedCartId: true)
        self.pushViewController(vc, animated: true)
    }
    // 商品加减操作
    func itemNumberCallBack(section: Int,row: Int, number: Int){
        if (!cartListData!.list.isEmpty && section == 0){
            cartListData?.list[row].num = number
            // 调接口修改数量
            editCartGoods(id: String(cartListData?.list[row].cart_id ?? 0), number: String(number))
        } else if (!cartListData!.list.isEmpty){
            cartListData?.mch_list[section-1].list[row].num = number
            // 调接口修改数量
            editCartGoods(id: String(cartListData?.mch_list[section-1].list[row].cart_id ?? 0), number: String(number))
        } else {
            cartListData?.mch_list[section].list[row].num = number
            // 调接口修改数量
            editCartGoods(id: String(cartListData?.mch_list[section].list[row].cart_id ?? 0), number: String(number))
        }
        // 这里触发更新价格
        let p = isCheckArray[0][0]
        isCheckArray[0][0] = p
        
    }
    // 选择全部
    func selectAll(check: Bool) {
        for (index, item) in isCheckArray.enumerated(){
            for (i,_) in item.enumerated() {
                isCheckArray[index][i] = check
            }
        }
        shopCartView.reloadData()
    }
    // 选择一组
    func selectSection(section: Int, check: Bool) {
        for (index, _) in isCheckArray[section].enumerated() {
            isCheckArray[section][index] = check
        }
        shopCartView.reloadData()
    }
    // 选择一个
    func selectItem(section:Int, row:Int, check: Bool) {
        isCheckArray[section][row] = check
        shopCartView.reloadData()
    }
}

extension UShopCartViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return isCheckArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isCheckArray[section].count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UShopCartHeaderView()
        header.delegate = self
        header.isCheck = true
        for item in isCheckArray[section]{
            if (!item){
                header.isCheck = false
                break
            }
        }
        header.section = section
        // 如果平台自营的商品列表不为空 并且section为0 则设置平台自营
        if (!(cartListData?.list ?? []).isEmpty && section == 0){
            header.storeIcon.image = UIImage.init(named: "AppIcon")
            header.mchName = "平台自营"
        } else {
            header.iconUrl = cartListData?.mch_list[section].logo
            header.mchName = cartListData?.mch_list[section].name
        }
        header.frame = tableView.bounds
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 59 : 74
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UShopCartGoodsCell.self)
        if (indexPath.section == 0 && !(cartListData?.list ?? []).isEmpty){
            // 平台自营商品的cell数据处理
            var attr = ""
            for item in cartListData!.list[indexPath.section].attr_list{
                attr += "\(item.attr_group_name):\(item.attr_name)  "
            }
            
            let data = ["picUrl":cartListData!.list[indexPath.section].goods_pic,
                        "goodsName":cartListData!.list[indexPath.section].goods_name,
                        "attr":attr,
                        "price":String(cartListData!.list[indexPath.section].price)]
            cell.data = data
        } else {
            // 其他普通商家的cell数据处理
            var attr = ""
            for item in cartListData!.mch_list[indexPath.section].list[indexPath.row].attr_list{
                attr += "\(item.attr_group_name):\(item.attr_name)  "
            }
            
            let data = ["picUrl":cartListData!.mch_list[indexPath.section].list[indexPath.row].goods_pic,
                        "goodsName":cartListData!.mch_list[indexPath.section].list[indexPath.row].goods_name,
                        "attr":attr,
                        "price":String(cartListData!.mch_list[indexPath.section].list[indexPath.row].price)]
            cell.data = data
        }
        // 数量
        cell.maxNumber = cartListData!.mch_list[indexPath.section].list[indexPath.row].max_num
        cell.currentNumber = cartListData!.mch_list[indexPath.section].list[indexPath.row].num
        cell.isCheck = isCheckArray[indexPath.section][indexPath.row]
        cell.section = indexPath.section
        cell.row = indexPath.row
        cell.delegate = self
        return cell
    }
    
    
}
