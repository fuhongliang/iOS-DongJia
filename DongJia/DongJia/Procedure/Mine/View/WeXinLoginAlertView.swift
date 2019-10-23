//
//  WeXinLoginAlertView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/23.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class WeXinLoginAlertView: BaseView {

    override func configUI() {
        
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 150)
        
        let close = UIImageView(frame: CGRect(x: 250, y: 0, width: 20, height: 20)).then{
            $0.image = UIImage.init(named: "delete_address")
        }
        let title = UILabel(frame: CGRect(x: 250, y: 0, width: 20, height: 20)).then{
            $0.text = "测试"
        }
        let subTitle = UILabel().then{
            $0.text = "测试内容"
        }
        let btn = UIButton().then{
            $0.setTitle("测试按钮", for: .normal)
        }
        
        self.addSubview(close)
        self.addSubview(title)
        self.addSubview(subTitle)
        self.addSubview(btn)
        
        //MARK:close
        close.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.size.equalTo(20)
        }
        //MARK:title
        title.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(close.snp.bottom)
        }
        //MARK:subTitle
        subTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(10)
        }
        //MARK:btn
        btn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
        }
        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        
        
    }
    @objc func testAction() {
        showHUDInView(text: "测试", inView: topVC!.view, isClick: true)
    }
    
}
