//
//  AddToCartPostAttrModel.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/21.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import Foundation

struct add_to_cart_post_attr_model: Codable{
    init(array: [post_attr_model]) {
        self.array = array
    }
    var array: [post_attr_model]
}
struct post_attr_model: Codable {
    init(attr_group_id: Int,attr_group_name: String,attr_id: Int,attr_name: String) {
        self.attr_group_id = attr_group_id
        self.attr_group_name = attr_group_name
        self.attr_id = attr_id
        self.attr_name = attr_name
    }
    var attr_group_id: Int
    var attr_group_name: String
    var attr_id: Int
    var attr_name: String
}
