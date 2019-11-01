//
//  UDosController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIDosController: UBaseViewController {
    
    private let service = APIDosServices()
    
    var currentPage = 1 // 当前的页数
    var currentPageForItem = 0 // 当前页的数据大小
    /// 当前是否已经是最大页数
    var isMaxPage: Bool{
        get {
            return currentPageForItem < 6
        }
    }

    var data:[dos_model]? {
        didSet{
            guard data == nil else {
                tableView.reloadData()
                return
            }
        }
    }
    
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .background
        $0.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = UITableViewCell.SeparatorStyle.none
        $0.showsVerticalScrollIndicator = false
        $0.register(cellType: UDosCell.self)
    }
    
    
    override func configUI() {
        tableView.uempty = UEmptyView { [weak self] in self?.refreshDosList() }
        tableView.uHead = URefreshHeader { [weak self] in self?.refreshDosList() }
        tableView.uFoot = URefreshFooter { [weak self] in self?.getDosList()}
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        getDosList()
    }
    
    func refreshDosList(){
        currentPage = 1
        getDosList()
    }
    
    func getDosList(){
        checkLoginState {
            service.getDosList(page: currentPage, { (DosList) in
                self.currentPageForItem = DosList.data.list.count
                if (self.currentPage == 1){
                    self.data = DosList.data.list
                    self.tableView.uHead.endRefreshing()
                } else {
                    self.data?.append(contentsOf: DosList.data.list)
                }
                if (self.isMaxPage) {
                    self.tableView.uFoot.endRefreshingWithNoMoreData()
                } else {
                    self.currentPage += 1
                    self.tableView.uFoot.endRefreshing()
                }
                self.tableView.uempty?.allowShow = true
            }) { (APIErrorModel) in
                
            }
        }
    }

}

extension UIDosController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dosCellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView().then{ $0.backgroundColor = .background }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UDosCell.self)
        cell.model = data?[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushViewController(UIDosDetailController(), animated: true)
    }
    
    
}
