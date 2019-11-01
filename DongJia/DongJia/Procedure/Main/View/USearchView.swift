//
//  USearchView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/14.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import QMUIKit
import ZLCollectionViewFlowLayout

protocol USearchViewDelegate {
    func searchGoods(keyWord: String?)
    // 删除历史记录
    func clearHistory(index: Int)
    func clearSearch()
    
    func loadMore()
    
}

class USearchView: BaseView {
    
    var delegate: USearchViewDelegate?
    
    let searchBg = UIView().then {
        $0.backgroundColor = UIColor.hex(hexString: "#F5F5F5")
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
    }
    
    let searchImg = UIImageView().then {
        $0.image = UIImage.init(named: "magnifier")
    }
    
    let searchTf = UITextField().then {
        $0.placeholder = "请输入关键词搜索"
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    
    let clearBtn = UIButton().then {
        $0.setImage(UIImage.init(named: "clear"), for: .normal)
    }
    
    let searchBtn = UIButton().then{
        $0.setTitle("搜索", for: .normal)
        $0.setTitleColor(.theme, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 13)
    }

    var searchHistoryView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then{
        $0.showsVerticalScrollIndicator = false
        $0.layer.cornerRadius = 4
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
        $0.isHidden = true
        $0.register(cellType: UMyCollectionCell.self)
    }
    
    let layout = ZLCollectionViewVerticalLayout().then{
        $0.estimatedItemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.itemSize = CGSize(width: collectionCellWidth, height: 213)//设置cell的大小
        $0.sectionInset = UIEdgeInsets.init(top: 15, left: 0, bottom: 15, right: 0)
        
        $0.canDrag = true
        $0.header_suspension = false
    }
    
    let historyLabel = UILabel().then{
        $0.text = "历史搜索(长按删除)"
        $0.textColor = .hex(hexString: "#999999")
        $0.font = .systemFont(ofSize: 11)
    }
    let clearHistoryBtn = UIButton().then{
        $0.setImage(UIImage.init(named: "delete_address"), for: .normal)
    }
    
    let flowView = QMUIFloatLayoutView().then{
        $0.itemMargins = .init(top: 0, left: 0, bottom: 10, right: 10)
        $0.backgroundColor = .white
    }
    
    override func configUI() {
        
        self.backgroundColor = .white
        layout.delegate = self
        searchHistoryView.collectionViewLayout = layout
        
        self.addSubview(historyLabel)
        self.addSubview(clearHistoryBtn)
        self.addSubview(flowView)
        
        self.addSubview(searchBg)
        searchBg.addSubview(searchImg)
        searchBg.addSubview(searchTf)
        searchBg.addSubview(clearBtn)
        self.addSubview(searchBtn)
        self.addSubview(searchHistoryView)
        searchHistoryView.uFoot = URefreshFooter { [weak self] in self?.delegate?.loadMore() }
        
        searchBtn.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        clearBtn.addTarget(self, action: #selector(clearSearchAction), for: .touchUpInside)
        clearHistoryBtn.addTarget(self, action: #selector(clearHistoryAction), for: .touchUpInside)
        
        //MARK:灰色圆角搜索背景
        searchBg.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: screenWidth-80,height: 30))
        }
        //MARK:🔍放大镜
        searchImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(15)
            make.centerY.equalToSuperview()
        }
        //MARK:输入框
        searchTf.snp.makeConstraints { (make) in
            make.left.equalTo(searchImg.snp.right).offset(10)
            make.height.top.equalToSuperview()
            make.right.equalToSuperview().offset(-25)
        }
        //MARK:清空输入
        clearBtn.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.right.centerY.equalToSuperview()
        }
        //MARK:搜索
        searchBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width:70, height: 40))
            make.right.equalToSuperview()
            make.centerY.equalTo(searchBg)
        }
        
        //MARK:列表
        searchHistoryView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBtn.snp.bottom)
            make.width.bottom.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        //MARK:历史搜索
        historyLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(searchBtn.snp.bottom).offset(18)
        }
        
        //MARK:清除搜索历史
        clearHistoryBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(historyLabel)
            make.size.equalTo(15)
        }
        
        //MARK:自动排列view
        flowView.snp.makeConstraints { (make) in
            make.top.equalTo(historyLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
    }
    
    /// 清空输入框
    @objc func clearSearchAction(){
        searchTf.text = ""
        delegate?.clearSearch()
    }
    
    /// 搜索
    @objc func searchAction(){
        delegate?.searchGoods(keyWord: searchTf.text)
    }
    
    /// 清理搜索记录
    @objc func clearHistoryAction(){
        showAlert(title: "提示", subTitle: "是否删除所有记录") { (alert) in
            alert.addButton("取消",backgroundColor: .white,textColor: .hex(hexString: "#333333")) { }
            alert.addButton("确定",backgroundColor: .white,textColor: .theme) {
                self.delegate?.clearHistory(index: -1)
            }
        }
    }
    
    @objc func historyAction(btn: QMUIButton){
        for (index,item) in history!.enumerated(){
            if index == btn.tag{
                searchTf.text = item
                delegate?.searchGoods(keyWord: searchTf.text)
                return
            }
        }
    }
    
    @objc func historyLongPressAction(_ gestureRecognizer: UILongPressGestureRecognizer?){
        for (index,_) in history!.enumerated(){
            if (index == gestureRecognizer?.view!.tag){
                self.delegate?.clearHistory(index: index)
                return
            }
        }
    }
    
    
    /// 生成搜索记录的按钮
    func generateHistoryBtn(historyList: [String]){
        flowView.qmui_removeAllSubviews()
        for (index, item) in historyList.enumerated(){
            let btn = QMUIButton().then{
                $0.tag = index
                $0.layer.cornerRadius = 3
                $0.setTitle(item, for: .normal)
                $0.setTitleColor(.hex(hexString: "#333333"), for: .normal)
                $0.backgroundColor = .hex(hexString: "#F5F5F5")
                $0.titleLabel?.font = .systemFont(ofSize: 12)
                $0.contentEdgeInsets = UIEdgeInsets(top: 9, left: 15, bottom: 9, right: 15)
            }
            /// 长按动作
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(historyLongPressAction))
            longPress.minimumPressDuration = 0.8
            btn.addTarget(self, action: #selector(historyAction(btn:)), for: .touchUpInside)
            btn.addGestureRecognizer(longPress)
            flowView.addSubview(btn)
        }
    }
    
    var history: [String]?{
        didSet{
            guard let history = history else { return }
            generateHistoryBtn(historyList: history)
        }
    }
    
}


extension USearchView: ZLCollectionViewBaseFlowLayoutDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, typeOfLayout section: Int) -> ZLLayoutType {
        return ClosedLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, columnCountOfSection section: Int) -> Int {
        return 2
    }
    
}
