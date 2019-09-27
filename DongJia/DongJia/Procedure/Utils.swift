//
//  Utils.swift
//  MYiMei
//
//  Created by 于亿鑫 on 2019/9/9.
//  Copyright © 2019 符宏梁. All rights reserved.
//

import UIKit

private var loadMoreView: UIView!
private var loadMoreViewActivity: UIActivityIndicatorView!

func getLoadMoreView(frame: CGRect) -> UIView{
    
    loadMoreView = UIView(frame:frame)
    loadMoreViewActivity = UIActivityIndicatorView()
    loadMoreView.backgroundColor = .background
    loadMoreView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
    //添加环形进度条
    loadMoreViewActivity.color = UIColor.black
    loadMoreViewActivity.startAnimating()
    
    loadMoreView.addSubview(loadMoreViewActivity)
    loadMoreViewActivity.snp.makeConstraints { (ConstraintMaker) in
        ConstraintMaker.center.equalToSuperview()
    }
    loadMoreViewActivity.hidesWhenStopped = true
    
    return loadMoreView
}

//MARK:打电话给客户
func callTheClient(phoneNumber:String){
    showAlert(title: "温馨提示", subTitle: "是否拨打该联系电话") { (alert) in
        alert.addButton("取消",textColor:UIColor.black){}
        alert.addButton("确定",textColor:UIColor.hex(hexString: "#1C98F6")){
            let phone = "telprompt://\(phoneNumber)"
            
            if UIApplication.shared.canOpenURL(URL(string: phone)!) {
                UIApplication.shared.openURL(URL(string: phone)!)
            }
        }
    }
    
}
