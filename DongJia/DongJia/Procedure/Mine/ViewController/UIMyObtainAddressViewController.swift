//
//  UIMyObtainAddressViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIMyObtainAddressViewController: UBaseViewController {
    
    var delegate: UIConfirmOrderControllerDelegate?
    
    private let service = APIAddressServices()
    
    let obtainAddressView = UMyObtainAddressView()
    
    /// 地址列表
    var addressList: [address_model]? {
        didSet{
            guard addressList != nil else { return }
            obtainAddressView.tableView.reloadData()
        }
    }
    
    override func configUI() {
        
        self.view.addSubview(obtainAddressView)
        obtainAddressView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        obtainAddressView.delegate = self
        obtainAddressView.tableView.delegate = self
        obtainAddressView.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyAddressList()
    }
    /// 获取地址列表
    func getMyAddressList(){
        checkLoginState {
            service.getMyAddressList({ (AddressList) in
                self.addressList = AddressList.data?.list
            }) { (APIErrorModel) in
                
            }
        }
        
    }
    /// 编辑默认地址
    func editIsDefaultAddress(index: Int){
        checkLoginState {
            service.addOrEditAddress(address_id: addressList![index].id, name: addressList![index].name, mobile: addressList![index].mobile, province_id: Int(addressList![index].province_id)!, city_id: Int(addressList![index].city_id)!, district_id: Int(addressList![index].district_id)!, detail: addressList![index].detail, is_default: "1", { (APIObjectModel) in
                self.getMyAddressList()
                print(APIObjectModel.msg ?? "=====")
            }, { (APIErrorModel) in
                
            })
        }
    }
    /// 删除地址
    func deleteAddress(index: Int){
        checkLoginState {
            service.deleteAddress(address_id: addressList![index].id, { (APIObjectModel) in
                self.getMyAddressList()
                print(APIObjectModel.msg ?? "=====")
            }, { (APIErrorModel) in
                
            })
        }
    }

}

extension UIMyObtainAddressViewController: UMyObtainAddressViewDelegate {
    
    func addAddress() {
        let vc = UIAddAddressController()
        vc.title = "新增地址"
        pushViewController(vc, animated: true)
    }
    
}

extension UIMyObtainAddressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addressList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UObtainAddressCell.self)
        cell.setDefaultAddress = {
            self.editIsDefaultAddress(index: indexPath.section)
        }
        cell.editAddress = {
            let vc = UIAddAddressController()
            vc.title = "编辑地址"
            vc.editAddress = self.addressList?[indexPath.section]
            self.pushViewController(vc, animated: true)
        }
        cell.deleteAddress = {
            self.deleteAddress(index: indexPath.section)
        }
        cell.model = addressList?[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (delegate != nil){
            delegate!.setAddress(address: addressList![indexPath.section])
            self.pressBack()
            delegate = nil
        }
    }
    
}
