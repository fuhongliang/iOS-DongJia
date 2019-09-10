//
//  UITextFieldExtension.swift
//  MYiMei
//
//  Created by 符宏梁 on 2019/7/20.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import Foundation

var _dl_LimitMaxLengthKey = "__dl_LimitMaxLengthKey"

var maxNumberKey:Double = 0

extension UITextField{
    
    //MARK:设置输入框类型为数字时 最大输入数字
    public var maxTextNumber: Double {
        set {
            objc_setAssociatedObject(self, &maxNumberKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            if maxNumberKey > 0 {
                self.addTarget(self, action: #selector(checkTextFieldText), for: .allEditingEvents)
            } else {
                self.removeTarget(self, action: #selector(checkTextFieldText), for: .allEditingEvents)
            }
        }
        get {
            if let rs = objc_getAssociatedObject(self, &maxNumberKey) as? Double {
                return rs
            }
            return 0
        }
    }
    /// 检测如果输入数高于设置最大输入数则置为最大数
    @objc func checkTextFieldText(){
        guard self.keyboardType == .numberPad && self.keyboardType == .decimalPad else {
            if Double(self.text ?? "0.0")! >= maxTextNumber {
                self.text = String(maxTextNumber)
            }
            return
        }
    }
    
    //MARK:设置输入框最大输入长度
    var dl_maxLength:Int32 {
        get {
            return (objc_getAssociatedObject(self, &_dl_LimitMaxLengthKey) as AnyObject).int32Value
        }
        set(dl_maxLength) {
            objc_setAssociatedObject(self, &_dl_LimitMaxLengthKey, "\(dl_maxLength)", objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            if dl_maxLength > 0 {
                self.addTarget(self, action: #selector(_dl_valueChanged(_:)), for: .allEditingEvents)
            } else {
                self.removeTarget(self, action: #selector(_dl_valueChanged(_:)), for: .allEditingEvents)
            }
        }
    }
    @objc fileprivate func _dl_valueChanged(_ textfiled:UITextField) {
        if self.dl_maxLength == 0 {
            return
        }
        let currentLength = Int32((textfiled.text?.count)!)
        if currentLength <= self.dl_maxLength {
            return
        }
        let index = textfiled.text!.index(textfiled.text!.startIndex, offsetBy: Int(self.dl_maxLength))
        let subString = textfiled.text?.substring(to: index)
        DispatchQueue.main.async {
            textfiled.text = subString
            textfiled.sendActions(for: .editingChanged)
        }
    }
}

