//
//  UOrderStoreInfoFooterView.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/21.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit
import QMUIKit
class UOrderStoreInfoFooterView: BaseView {
    
    var editMessage: ((_ leaveMessage: String)->())?
    
    let line = UIView().then{
        $0.backgroundColor = .hex(hexString: "#F2F2F2")
    }
    
    let leaveMessageLabel = UILabel().then{
        $0.text = "留言:"
        $0.textColor = .hex(hexString: "#333333")
        $0.font = .systemFont(ofSize: 16)
    }
    
    let leaveMessageTf = QMUITextField().then{
        $0.placeholder = "点击填写留言"
        $0.font = .systemFont(ofSize: 16)
    }
    
    override func configUI() {
        
        backgroundColor = .white
        
        self.addSubview(line)
        self.addSubview(leaveMessageLabel)
        self.addSubview(leaveMessageTf)
        
        //MARK:分割线
        line.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview().offset(15)
            make.height.equalTo(1)
        }
        //MARK:留言Label
        leaveMessageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        //MARK:留言输入框
        leaveMessageTf.snp.makeConstraints { (make) in
            make.left.equalTo(leaveMessageLabel.snp.right).offset(20)
            make.size.equalTo(CGSize(width: screenWidth-95, height: 44))
            make.top.equalTo(line.snp.bottom)
            make.bottom.equalToSuperview()
        }
        leaveMessageTf.delegate = self
        
    }

    var message: String = ""{
        didSet{
            leaveMessageTf.text = message
        }
    }
    
}
extension UOrderStoreInfoFooterView: QMUITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        let leveMessage = textField.text ?? ""
        editMessage?(leveMessage)
    }
}
