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
    
    var isNewAddress: Bool = false
    
    var editAddressId: String = "0"
    
    override func configUI() {
        self.view.addSubview(addAddressView)
        addAddressView.delegate = self
        addAddressView.setHaveDefault(isHiddenDefault: isNewAddress)
        
        addAddressView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (!isNewAddress) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "删除",titleColor: .black, target: self, action: #selector(deleteAddress))
//            addAddressView.addressInfo = "广东省 广州市 海珠区"
        }
    }
    
    /// 获取省市区数据
    func getDistrictList(){
        service.getDistrictList({ (DistrictList) in
            self.districtList = DistrictList.data
            self.showKLCityPickerView()
        }) { (APIErrorModel) in
            
        }
    }
    
    @objc func deleteAddress(){
        showHUDInView(text: "删除", inView: self.view, isClick: true)
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
        getDistrictList()
    }
    
    func saveAddress(name: String, phone: String, chooseAddress: String, houseNumber: String, isDefalut: Bool) {
        
        service.addOrEditAddress(address_id: isNewAddress ? "" : editAddressId, name: name, mobile: phone, province_id: currentProvinceId ?? 0, city_id: currentCityId ?? 0, district_id: currentAreaId ?? 0, detail: houseNumber, is_default: isDefalut ? 1 : 0, { (APIObjectModel) in
            self.pressBack()
        }) { (APIErrorModel) in
            showHUDInView(text: APIErrorModel.msg ?? "", inView: self.view, isClick: true)
        }
        showHUDInView(text: "保存操作", inView: self.view, isClick: true)
       

    }
    
    
}
