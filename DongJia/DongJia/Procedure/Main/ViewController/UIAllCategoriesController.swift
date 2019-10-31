//
//  UIAllCategoriesController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/30.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIAllCategoriesController: UBaseViewController {
    
    var catList: [primary_list_model]?{
        didSet{
            guard catList != nil else { return }
            categoriesView.primaryList = catList
        }
    }
    
    private let service = APIMainService()

    let categoriesView = UAllCategoriesView()
    override func configUI() {
        categoriesView.delegate = self
        view.addSubview(categoriesView)
        categoriesView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        getCatList()
    }
    
    func getCatList(){
        service.catList({ (CatList) in
            self.catList = CatList.data.list
        }) { (APIErrorModel) in
            
        }
    }
    
}
extension UIAllCategoriesController: UAllCategoriesViewDelegate{
    func primaryClassificationClick(_ index: Int) {
        categoriesView.secondartList = catList![index].list
    }
    
    func secondaryClassificationClick() {
        
    }
    
    
}
