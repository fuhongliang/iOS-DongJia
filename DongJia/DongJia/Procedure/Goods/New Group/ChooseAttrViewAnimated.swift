//
//  ChooseAttrViewAnimated.swift
//  DongJia
//
//  Created by 于亿鑫 on 2019/10/15.
//  Copyright © 2019 hongshuzhi. All rights reserved.
//

import UIKit

//选择规格的弹出与收回动画
class ChooseAttrViewAnimated: NSObject,UIViewControllerAnimatedTransitioning {
    
    var type: PickerPresentAnimateType = .present
    
    init(type: PickerPresentAnimateType) {
        self.type = type
    }
    /// 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    /// 动画效果
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch type {
        case .present:
            guard let toVC = transitionContext.viewController(forKey: .to) as? UIChooseAttrViewController else {
                return
            }
            //            let toVC : EWDatePickerViewController = transitionContext.viewController(forKey: .to) as? EWDatePickerViewController
            let toView = toVC.view
            
            let containerView = transitionContext.containerView
            containerView.addSubview(toView!)
            
            toVC.chooseView.transform = CGAffineTransform(translationX: 0, y: (toVC.chooseView.frame.height))
            UIView.animate(withDuration: 0.35, animations: {
                toVC.chooseView.transform = CGAffineTransform.identity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        case .dismiss:
            guard let toVC = transitionContext.viewController(forKey: .from) as? UIChooseAttrViewController else {
                return
            }
            UIView.animate(withDuration: 0.35, animations: {
                toVC.view.alpha = 0
                /// datepicker向下推回
                toVC.chooseView.transform =  CGAffineTransform(translationX: 0, y: (toVC.chooseView.frame.height))
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
