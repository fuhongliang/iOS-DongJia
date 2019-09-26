//
//  UIAddAddressController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/20.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIAddAddressController: UBaseViewController {
    /// 当前选择的省份
    var currentProvince:String?
    /// 当前选择的城市
    var currentCity:String?
    /// 当前选择的地区
    var currentArea:String?

    let addAddressView = UAddAddressView()
    
    var isNewAddress: Bool = false
    
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
            addAddressView.addressInfo = "广东省 广州市 海珠区"
        }
    }
    
    @objc func deleteAddress(){
        showHUDInView(text: "删除", inView: self.view, isClick: true)
    }

}

extension UIAddAddressController: UAddAddressViewDelegate {
    func chooseAddress() {
        let address = KLCityPickerView()
        address.areaPickerViewWithProvince(province: currentProvince, city: currentCity, area: currentArea) { (province, city, area) in
            self.currentProvince = province
            self.currentCity = city
            self.currentArea = area
            self.addAddressView.city.text = "\(province) \(city) \(area)"
        }
    }
    
    func saveAddress(name: String, phone: String, chooseAddress: String, houseNumber: String, isDefalut: Bool) {
        guard name == "" else {
            showHUDInView(text: "收货人不能为空", inView: self.view, isClick: true)
            return
        }
        guard phone == "" else {
            showHUDInView(text: "手机号不能为空", inView: self.view, isClick: true)
            return
        }
        guard chooseAddress == "" else {
            showHUDInView(text: "请先选择城市地区", inView: self.view, isClick: true)
            return
        }
        guard houseNumber == "" else {
            showHUDInView(text: "详细地址不能为空", inView: self.view, isClick: true)
            return
        }
        showHUDInView(text: "保存操作", inView: self.view, isClick: true)
       

    }
    
    
}
