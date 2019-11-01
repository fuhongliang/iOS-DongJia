//
//  UIChooseCityController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIChooseCityController: UBaseViewController {
    private let service = APIMainService()

    let chooseCityView = UChooseCityView()
    
    var supportCityList: [support_city_model]? {
        didSet{
            chooseCityView.collectionView.reloadData()
        }
    }
    
    override func configUI() {
        view.addSubview(chooseCityView)
        chooseCityView.currentCity.text = getCity()
        chooseCityView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        chooseCityView.collectionView.delegate = self
        chooseCityView.collectionView.dataSource = self
        getSupportCity()
    }
    
    func getSupportCity(){
        service.getSupportCityList({ (SupportCity) in
            self.supportCityList = SupportCity.data
        }) { (APIErrorModel) in
            
        }
    }

}

extension UIChooseCityController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return supportCityList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: UChooseCityCell.self)
        cell.city = supportCityList![indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.chooseCityView.currentCity.text = supportCityList![indexPath.item].name
        saveCity(supportCityList![indexPath.item].name)
        self.pressBack()
    }
    
    
    
}
