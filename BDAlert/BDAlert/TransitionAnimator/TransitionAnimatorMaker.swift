//
//  @header TransitionAnimatorMaker.swift
//  BDAlert
//
//  Created by 诸葛游 on 2017/3/23.
//  Copyright © 2017年 诸葛游. All rights reserved.
//  @author 诸葛游
//  @copyright Copyright © 2017年 诸葛游. All rights reserved.
//  @version 2017/3/23.

import UIKit


enum BDCustomModalTransitionStyle {
    case coverVertical_custom
    case crossDissolve_custom
}

class TransitionAnimatorMaker: NSObject {
    
    class func presentAnimator(style: BDCustomModalTransitionStyle, duration: TimeInterval) -> TransitionAnimator {
        switch style {
        case .coverVertical_custom:
            return self.sheetPresentAnimator(duration: duration)
        case .crossDissolve_custom:
            return self.alertPresentAnimator(duration: duration)
        }
    }
    
    class func dismissAnimator(style: BDCustomModalTransitionStyle, duration: TimeInterval) -> TransitionAnimator {
        switch style {
        case .coverVertical_custom:
            return self.sheetDissmissAnimator(duration: duration)
        case .crossDissolve_custom:
            return self.alertDismissAnimator(duration: duration)
        }
    }
    
    /// 创建一个 alert 的 present 动画对象
    ///
    /// - Returns: alertPresentAnimator
    class func alertPresentAnimator(duration: TimeInterval) -> TransitionAnimator {
        let presentAnimator = TransitionAnimator(duration: duration, animations: { (transitionContext, duration) in
            
            guard let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
            }
            guard let alertController = toController as? BDAlertController else {
                return
            }
            
            let containerView = transitionContext.containerView
            containerView.addSubview(alertController.view)
            
            alertController.contentView.frame = alertController.contentFrame
            alertController.overlayView.alpha = 0
            alertController.contentView.alpha = 0
            alertController.contentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            
            UIView.animate(withDuration: duration, animations: {
                alertController.overlayView.alpha = 0.4
                alertController.contentView.alpha = 1
                alertController.contentView.transform = CGAffineTransform.identity
                
            }, completion: { (animateCompleted) in
                transitionContext.completeTransition(animateCompleted)
            })
        }, completion: { (transitionCompleted) in
            
        })
        
        return presentAnimator
    }
    
    
    /// 创建一个 alert 的 dismiss 动画对象
    ///
    /// - Returns: alertDismissAnimator
    class func alertDismissAnimator(duration: TimeInterval) -> TransitionAnimator {
        let dismissAnimator = TransitionAnimator(duration: duration, animations: { (transitionContext, duration) in
            
            guard let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
                return
            }
            guard let alertController = fromController as? BDAlertController else {
                return
            }
            
            UIView.animate(withDuration: duration, animations: {
                alertController.overlayView.alpha = 0
                alertController.contentView.alpha = 0
                alertController.contentView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                
            }, completion: { (animateCompleted) in
                transitionContext.completeTransition(animateCompleted)
            })
        }, completion: { (transitionCompleted) in
            
        })
        
        return dismissAnimator
    }
    
    /// 创建一个 sheet 的 present 动画对象
    ///
    /// - Returns: sheetPresentAnimator
    class func sheetPresentAnimator(duration: TimeInterval) -> TransitionAnimator {
        let presentAnimator = TransitionAnimator(duration: duration, animations: { (transitionContext, duration) in
            
            guard let toController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
            }
            guard let alertController = toController as? BDAlertController else {
                return
            }
            
            let containerView = transitionContext.containerView
            containerView.addSubview(alertController.view)
            
            var orignalFrame =  alertController.contentFrame
            orignalFrame.origin.y = alertController.view.frame.height
            
            alertController.contentView.frame = orignalFrame
            alertController.overlayView.alpha = 0
            
            UIView.animate(withDuration: duration, animations: {
                alertController.overlayView.alpha = 0.4
                alertController.contentView.frame = alertController.contentFrame
                
            }, completion: { (animateCompleted) in
                transitionContext.completeTransition(animateCompleted)
            })
        }, completion: { (transitionCompleted) in
            
        })
        
        return presentAnimator
    }
    
    
    /// 创建一个 sheet 的 dismiss 动画对象
    ///
    /// - Returns: sheetDissmissAnimator
    class func sheetDissmissAnimator(duration: TimeInterval) -> TransitionAnimator {
        let dismissAnimator = TransitionAnimator(duration: duration, animations: { (transitionContext, duration) in
            
            guard let fromController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
                return
            }
            guard let alertController = fromController as? BDAlertController else {
                return
            }
            
            var orignalFrame =  alertController.contentFrame
            orignalFrame.origin.y = alertController.view.frame.height
            
            UIView.animate(withDuration: duration, animations: {
                alertController.overlayView.alpha = 0
                alertController.contentView.frame = orignalFrame
            }, completion: { (animateCompleted) in
                transitionContext.completeTransition(animateCompleted)
            })
        }, completion: { (transitionCompleted) in
            
        })
        
        return dismissAnimator
    }
}
