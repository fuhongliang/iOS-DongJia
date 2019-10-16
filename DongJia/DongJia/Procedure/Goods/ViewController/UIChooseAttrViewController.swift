//
//  UIChooseAttrViewController.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/15.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

class UIChooseAttrViewController: UBaseViewController {
    
    let chooseView = UChooseAttrView()
    override func configUI() {
        chooseView.frame = CGRect(x: 0, y: screenHeight*0.3, width: screenWidth, height: screenHeight*0.7)
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
        }
    }

}

extension UIChooseAttrViewController: UChooseAttrViewProtocol,UIViewControllerTransitioningDelegate{
    func dismissAction() {
        self.dismiss(animated: true)
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
