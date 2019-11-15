//
//  UIAddAddressController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIAddAddressController: UBaseViewController {
    
    var districtList: [district_province_list]?
    
    private var service = APIAddressServices()
    
    /// 当前选择的省份id
    var currentProvinceId: Int?
    /// 当前选择的城市id
    var currentCityId: Int?
    /// 当前选择的地区id
    var currentAreaId: Int?
    
    /// 当前选择的省份
    var currentProvince: String?
    /// 当前选择的城市
    var currentCity: String?
    /// 当前选择的地区
    var currentArea: String?

    let addAddressView = UAddAddressView()
    
    /// 被编辑的地址  如果此值为空则是新建地址
    var editAddress: address_model?
    
    override func configUI() {
        self.view.addSubview(addAddressView)
        addAddressView.delegate = self
        addAddressView.setHaveDefault(isHiddenDefault: editAddress == nil)
        addAddressView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        getDistrictList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (editAddress != nil) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "删除",titleColor: .black, target: self, action: #selector(deleteAddress))
            currentProvinceId = Int(editAddress!.province_id)
            currentCityId = Int(editAddress!.city_id)
            currentAreaId = Int(editAddress!.district_id)
            
            currentProvince = editAddress!.province
            currentCity = editAddress!.city
            currentArea = editAddress!.district
            
            addAddressView.addressInfo = "\(currentProvince!) \(currentCity!) \(currentArea!)"
            addAddressView.contactNameTf.text = editAddress!.name
            addAddressView.phoneTf.text = editAddress!.mobile
            addAddressView.houseNumberTf.text = editAddress!.detail
        }
    }
    
    /// 获取省市区数据
    func getDistrictList(){
        service.getDistrictList({ (DistrictList) in
            self.districtList = DistrictList.data
            
        }) { (APIErrorModel) in
            print(APIErrorModel.msg ?? "获取省市区数据异常")
        }
    }
    
    @objc func deleteAddress(){
        showAlert(subTitle: "是否删除此地址") { (alert) in
            alert.addButton("取消",backgroundColor:.white, textColor: .hex(hexString: "#666666")){}
            alert.addButton("确认",backgroundColor:.theme, textColor: .white){
                self.service.deleteAddress(address_id: self.editAddress!.id, { (APIObjectModel) in
                    print(APIObjectModel.msg ?? "-----")
                    self.pressBack()
                }, { (APIErrorModel) in
                    
                })
            }
        }
    }
    
    /// 显示省市区弹窗
    func showKLCityPickerView(){
        let address = KLCityPickerView()
        
        address.areaPickerViewWithProvince(data: districtList ?? [], province: currentProvince, city: currentCity, area: currentArea) { (provinceIndex, cityIndex, areaIndex) in
            self.currentProvinceId = self.districtList?[provinceIndex].id
            self.currentCityId = self.districtList?[provinceIndex].list[cityIndex].id
            self.currentAreaId = self.districtList?[provinceIndex].list[cityIndex].list[areaIndex].id
            
            let province = self.districtList?[provinceIndex].name
            let city = self.districtList?[provinceIndex].list[cityIndex].name
            let area = self.districtList?[provinceIndex].list[cityIndex].list[areaIndex].name
            self.addAddressView.addressInfo = "\(province!) \(city!) \(area!)"
        }
    }

}

extension UIAddAddressController: UAddAddressViewDelegate {
    func chooseAddress() {
        showKLCityPickerView()
    }
    
    func saveAddress(name: String, phone: String, chooseAddress: String, houseNumber: String, isDefalut: Bool) {
        
        service.addOrEditAddress(address_id: editAddress?.id ?? "", name: name, mobile: phone, province_id: currentProvinceId ?? 0, city_id: currentCityId ?? 0, district_id: currentAreaId ?? 0, detail: houseNumber, is_default: isDefalut ? "1" : "0", { (APIObjectModel) in
            self.pressBack()
        }) { (APIErrorModel) in
            showHUDInView(text: APIErrorModel.msg ?? "", inView: self.view, isClick: true)
        }

    }
    
    
}
