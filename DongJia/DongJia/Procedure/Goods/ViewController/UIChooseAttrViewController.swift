//
//  UIChooseAttrViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/15.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIChooseAttrViewController: UBaseViewController {
    
    var delegate: UIGoodsDetailControllerDelegate?
    
    /// 商品属性数据
    var attrData: [goods_detail_attr_group_list]!
    /// 商品ID
    var goodsId: String = "-1"
    
    let chooseView = UChooseAttrView()
    override func configUI() {
        chooseView.attrData = attrData
        chooseView.currentGoodsId = goodsId
        chooseView.frame = CGRect(x: 0, y: screenHeight*0.3, width: screenWidth, height: screenHeight*0.7)
        //设置切部分圆角
        chooseView.setRoundCorners(corners: [.topLeft,.topRight], with: 10)
        self.modalPresentationStyle = .custom
        self.view.addSubview(chooseView)
        chooseView.delegate = self
        
        self.transitioningDelegate = self as UIViewControllerTransitioningDelegate//自定义转场动画
    }
    ///点击任意位置view消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let currentPoint = touches.first?.location(in: self.view)
        if !self.chooseView.frame.contains(currentPoint ?? CGPoint()) {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.chooseAttrCallBack(attr: chooseView.currentChooseAttr,addCartOrBuyOrDismiss: "dismiss")
        }
    }

}

extension UIChooseAttrViewController: UChooseAttrViewProtocol,UIViewControllerTransitioningDelegate{
    func dismissAction() {
        self.dismiss(animated: true)
        self.delegate?.chooseAttrCallBack(attr: chooseView.currentChooseAttr,addCartOrBuyOrDismiss: "dismiss")
    }
    func buyNowAction() {
        self.dismiss(animated: true)
        self.delegate?.chooseAttrCallBack(attr: chooseView.currentChooseAttr,addCartOrBuyOrDismiss: "buyNow")
        
    }
    // MARK: - 转场动画delegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = ChooseAttrViewAnimated(type: .present)
        return animated
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = ChooseAttrViewAnimated(type: .dismiss)
        return animated
    }

    
}
