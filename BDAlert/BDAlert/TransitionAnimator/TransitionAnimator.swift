//
//  TransitionAnimator.swift
//  BDAlert
//
//  Created by 诸葛游 on 2017/3/23.
//  Copyright © 2017年 诸葛游. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject {

    fileprivate var animateDuration: TimeInterval = 0.25
    fileprivate var animationHandler: ((_ transitionContext: UIViewControllerContextTransitioning, _ duration: TimeInterval) ->Void)?
    fileprivate var completionHanler: ((Bool) -> Void)?
    
    // MARK: - Initialization
    init(duration : TimeInterval = 0.25 , animations:((_ transitionContext: UIViewControllerContextTransitioning, _ duration: TimeInterval) -> Void)? = nil, completion:((Bool) -> Void)? = nil) {
        super.init()
        animateDuration = duration
        animationHandler = animations
        completionHanler = completion
    }
    
}

// MARK: - extension TransitionAnimator: UIViewControllerAnimatedTransitioning
extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animateDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let animationHandler = animationHandler {
            animationHandler(transitionContext, animateDuration)
        }
        
    }
    
    public func animationEnded(_ transitionCompleted: Bool) {
        if let completionHanler = completionHanler {
            completionHanler(transitionCompleted)
        }
    }
}

// MARK: - extension TransitionAnimator: UIViewControllerTransitioningDelegate
extension TransitionAnimator: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
