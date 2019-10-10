//
//  UIStoreController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/8.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

enum storeItem {
    /// 店铺信息
    case storeInfo
    /// 爆款推荐
    case hotRecommend
    /// 精品案例
    case classicCase
    /// 设计团队
    case designTeam
    /// 精选必买
    case willBuy
}

class UIStoreController: UBaseTableViewController {
    
    var cells: [storeItem] = [.storeInfo,.hotRecommend]
    
    /// 店铺ID
    var storeId: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configTableView(){
        
        tableView.backgroundColor = .background
        tableView.separatorInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: UStoreMainInfoCell.self)
        tableView.register(cellType: UStoreHotRecommendCell.self)
    }
    
    func getHeaderTitle(viewForHeaderInSection section: Int) -> String?{
        let index = cells[section]
        switch index {
        case .hotRecommend:
            return "爆款推荐"
        case .classicCase:
            return "精品案例"
        case .designTeam:
            return "设计团队"
        case .willBuy:
            return "精选必买"
        default:
            return nil
        }
    }
    
    /// 获取有头部cell的HeaderView
    /// title -> 左边的标题
    /// count -> 右边总数
    func getHeaderView(viewForHeaderInSection section: Int) -> UIView? {
        let index = cells[section]
        guard let title = getHeaderTitle(viewForHeaderInSection: section) else { return nil }
        let view = UIView(frame:CGRect(x: 0, y: 0, width: screenWidth, height: 45))
        let titleLabel = UILabel().then{
            $0.text = title
            $0.font = UIFont.boldSystemFont(ofSize: 17)
            $0.textColor = UIColor.black
            view.addSubview($0)
            $0.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(15)
                make.top.equalToSuperview().offset(20)
            })
        }
        let btn = UIButton().then{
            $0.setImage(UIImage(named: "right_arrow"), for: .normal)
            $0.addTarget(self, action: #selector(countAction), for: .touchUpInside)
            $0.setTitleColor(.hex(hexString: "#999999"), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 11)
        }
        switch index {
        case .classicCase:
            btn.setTitle("共\(12)个", for: .normal)
            view.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(-20)
                make.top.bottom.equalTo(titleLabel)
            })
            btn.setButtonShowType(.Left)
        case .designTeam:
            btn.setTitle("共\(24)人", for: .normal)
            view.addSubview(btn)
            btn.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(-20)
                make.top.bottom.equalTo(titleLabel)
            })
            btn.setButtonShowType(.Left)
        case .hotRecommend,.willBuy:
            return view
        default:
            return nil
        }
        return view
    }
    
    @objc func countAction(){
        showHUDInView(text: "总数点击", inView: self.view, isClick: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getHeaderView(viewForHeaderInSection: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard getHeaderTitle(viewForHeaderInSection: section) != nil else { return 0 }
        return 45
    }
  

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellMode = cells[indexPath.section]
        switch cellMode {
        case .storeInfo:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreMainInfoCell.self)
            cell.moreInfoBtnAction = { (isOpen) in
                UIView.animate(withDuration: 0.5) {
                    tableView.beginUpdates()
                    cell.brandInfo.numberOfLines = isOpen ? 0 : 3
                    tableView.endUpdates()
                    // 重新修改约束以达到动画效果
                }
            }
            return cell
        case .hotRecommend:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreHotRecommendCell.self)
            
            return cell
        case .classicCase:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreMainInfoCell.self)
            return cell
        case .designTeam:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreMainInfoCell.self)
            return cell
        case .willBuy:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UStoreMainInfoCell.self)
            return cell
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
