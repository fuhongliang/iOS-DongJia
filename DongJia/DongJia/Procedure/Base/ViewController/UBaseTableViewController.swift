//
//  UBaseTableViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/8.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    open func configTableView(){
        
    }
    
    // 默认没有footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

}
