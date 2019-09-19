//
//  UDosDetailView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/9/18.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

protocol UDosDetailViewDelegate {
    func contactDesignerAction()
    func goBack()
}

class UDosDetailView: BaseView {
    
    var delegate:UDosDetailViewDelegate?

    let dosImg = UIImageView()
    
    let goBack = UIButton().then{
        $0.setBackgroundImage(UIImage.init(named: "circle_back"), for: .normal)
    }
    
    let dosAuthorIcon = UIImageView().then{
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    let dosAuthorName = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor.hex(hexString: "#333333")
    }
    let dosTitle = UILabel().then{
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.numberOfLines = 0
    }
    let releaseTime = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#999999")
        $0.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    let line = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#F2F2F2")
    }
    let dosDetailText = UILabel().then{
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.numberOfLines = 0
    }
    let bottomWhiteBgView = UIView().then{
        $0.backgroundColor = .white
    }
    let bottomGrayBgView = UIView().then{
        $0.backgroundColor = .background
    }
    
    /// 联系设计师 白色背景
    let contactWhiteBg = UIButton().then{
        $0.backgroundColor = .white
    }
    let contactLine = UIView().then{
        $0.backgroundColor = UIColor.hex(hexString: "#CCCCCC")
    }
    let phoneImg = UIImageView().then{
        $0.image = UIImage.init(named: "phone")
    }
    let contactLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = UIColor.hex(hexString: "#333333")
        $0.text = "联系设计师"
    }
    
    override func configUI() {
        dosImg.image = UIImage.init(named: "todo_img")
        dosAuthorIcon.image = UIImage.init(named: "todo_img")
        dosAuthorName.text = "Alice_Arisu"
        dosTitle.text = "小姐姐的艺术公寓之：假装在北欧"
        releaseTime.text = "10分钟前"
        model =  " 二室二厅装修装饰布置必须确定布局的房子结构是否 合理，这将直接影响后期使用效果和生活质量。例如 隔音效果好的房间用作房间，客厅如何减少门的开启 确定厨房和炊具的位置，展示物品的选择，阳台是否 开放。在二室二厅装修过程中应遵循：使用尽可能多 的壁橱，吊柜和角柜作为改善，尽可能的利用空间， 尽可能考虑自然采光，考虑预埋水，电，通讯，有线 电视，音频等。 二室二厅装修装饰布置必须确定布局的房子结构是否 合理，这将直接影响后期使用效果和生活质量。例如 隔音效果好的房间用作房间，客厅如何减少门的开启 确定厨房和炊具的位置，展示物品的选择，阳台是否 开放。在二室二厅装修过程中应遵循：使用尽可能多 的壁橱，吊柜和角柜作为改善，尽可能的利用空间， 尽可能考虑自然采光，考虑预埋水，电，通讯，有线 电视，音频等。 二室二厅装修装饰布置必须确定布局的房子结构是否 合理，这将直接影响后期使用效果和生活质量。例如 隔音效果好的房间用作房间，客厅如何减少门的开启 确定厨房和炊具的位置，展示物品的选择，阳台是否 开放。在二室二厅装修过程中应遵循：使用尽可能多 的壁橱，吊柜和角柜作为改善，尽可能的利用空间， 尽可能考虑自然采光，考虑预埋水，电，通讯，有线 电视，音频等。 二室二厅装修装饰布置必须确定布局的房子结构是否 合理，这将直接影响后期使用效果和生活质量。例如 隔音效果好的房间用作房间，客厅如何减少门的开启 确定厨房和炊具的位置，展示物品的选择，阳台是否 开放。在二室二厅装修过程中应遵循：使用尽可能多 的壁橱，吊柜和角柜作为改善，尽可能的利用空间， 尽可能考虑自然采光，考虑预埋水，电，通讯，有线 电视，音频等。 二室二厅装修装饰布置必须确定布局的房子结构是否 合理，这将直接影响后期使用效果和生活质量。例如 隔音效果好的房间用作房间，客厅如何减少门的开启 确定厨房和炊具的位置，展示物品的选择，阳台是否 开放。在二室二厅装修过程中应遵循：使用尽可能多 的壁橱，吊柜和角柜作为改善，尽可能的利用空间， 尽可能考虑自然采光，考虑预埋水，电，通讯，有线 电视，音频等。 二室二厅装修装饰布置必须确定布局的房子结构是否 合理，这将直接影响后期使用效果和生活质量。例如 隔音效果好的房间用作房间，客厅如何减少门的开启 确定厨房和炊具的位置，展示物品的选择，阳台是否 开放。在二室二厅装修过程中应遵循：使用尽可能多 的壁橱，吊柜和角柜作为改善，尽可能的利用空间， 尽可能考虑自然采光，考虑预埋水，电，通讯，有线 电视，音频等。 "
        
        let scrollView = UIScrollView(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)).then{
            $0.showsVerticalScrollIndicator = false //是否显示滚动条
            $0.backgroundColor = .white
            $0.bounces = true //设置是否可以拉出空白区域
            $0.isScrollEnabled = true //设置允许滑动

        }
        
        self.addSubview(scrollView)
        
        scrollView.addSubview(dosImg)
        scrollView.addSubview(dosAuthorIcon)
        scrollView.addSubview(dosAuthorName)
        scrollView.addSubview(dosTitle)
        scrollView.addSubview(releaseTime)
        scrollView.addSubview(line)
        scrollView.addSubview(dosDetailText)
        scrollView.addSubview(bottomWhiteBgView)
        scrollView.addSubview(bottomGrayBgView)
        
        self.addSubview(goBack)
        goBack.addTarget(self, action: #selector(tapGoBack), for: .touchUpInside)
        self.addSubview(contactWhiteBg)
        contactWhiteBg.addSubview(contactLine)
        contactWhiteBg.addSubview(phoneImg)
        contactWhiteBg.addSubview(contactLabel)
        
        //MARK:滑动view
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //MARK:返回键
        goBack.snp.makeConstraints { (make) in
            make.size.equalTo(20)
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15+statusbarHeight)
        }
        //MARK:方案图片
        dosImg.snp.makeConstraints { (make) in
            make.width.equalTo(screenWidth)
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(screenWidth * 0.62)
        }
        //MARK:作者头像
        dosAuthorIcon.snp.makeConstraints { (make) in
            make.size.equalTo(24)
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(dosImg.snp.bottom).offset(12)
        }
        //MARK:作者名称
        dosAuthorName.snp.makeConstraints { (make) in
            make.centerY.equalTo(dosAuthorIcon)
            make.left.equalTo(dosAuthorIcon.snp.right).offset(11)
        }
        //MARK:方案标题
        dosTitle.snp.makeConstraints { (make) in
            make.left.equalTo(dosAuthorIcon)
            make.top.equalTo(dosAuthorIcon.snp.bottom).offset(12)
        }
        //MARK:发布时间
        releaseTime.snp.makeConstraints { (make) in
            make.left.equalTo(dosTitle)
            make.top.equalTo(dosTitle.snp.bottom).offset(9.5)
        }
        //MARK:🧵
        line.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(releaseTime.snp.bottom).offset(15)
            make.height.equalTo(2)
        }
        //MARK:方案内容文本
        dosDetailText.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(16)
            make.width.equalToSuperview().inset(15.5)
            make.centerX.equalToSuperview()
        }
        
        //MARK:详情文本下白色背景高度占位
        bottomWhiteBgView.snp.makeConstraints { (make) in
            make.left.width.equalToSuperview()
            make.height.equalTo(13.5)
            make.top.equalTo(dosDetailText.snp.bottom)
            make.left.equalToSuperview()
        }
        //MARK:scrollView底部灰色占位图
        bottomGrayBgView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomWhiteBgView.snp.bottom)
            make.left.bottom.width.equalToSuperview()
            make.height.equalTo(62)
        }
        
        //MARK:联系设计师白色背景
        contactWhiteBg.snp.makeConstraints { (make) in
            make.width.left.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        contactWhiteBg.addTarget(self, action: #selector(tapContactDesigner), for: .touchUpInside)
        
        //MARK:灰色线
        contactLine.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.left.width.equalToSuperview()
        }
        //MARK:联系设计师
        contactLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(14.5)
            make.centerY.equalToSuperview()
        }
        //MARK:phone图标
        phoneImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(contactLabel.snp.left).offset(-11)
        }
        
    }
    
    @objc func tapGoBack(){
        delegate?.goBack()
    }
    
    @objc func tapContactDesigner(){
        delegate?.contactDesignerAction()
    }
    
    var model: String? {
        didSet{
            guard let model = model else { return }
            dosDetailText.setTextAndLineSpacing(text:model, space:15)
        }
    }

}
