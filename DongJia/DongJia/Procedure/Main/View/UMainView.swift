//
//  UMainView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/10.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

class UMainView: BaseView {
    
    var delegate:UITableViewDelegate?
    var dataSource:UITableViewDataSource?

    let tableView = UITableView().then { (view) in
        view.frame = .zero
        view.backgroundColor = UIColor.hex(hexString: "#4ABBFF")
        view.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        view.separatorStyle = UITableViewCell.SeparatorStyle.none
        view.showsVerticalScrollIndicator = false
        
    }
    
    let view = UIView().then {
        $0.backgroundColor = UIColor.hex(hexString: "#4ABBFF")
    }
    
    override func configUI(){
        //MARK:添加tableview
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }

    }

}
