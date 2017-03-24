//
//  BDAlertController.swift
//  BDAlert
//
//  Created by 诸葛游 on 2017/3/20.
//  Copyright © 2017年 诸葛游. All rights reserved.
//  Remark: A Custom AlertController

import UIKit



fileprivate let SCREEN_WIDTH = UIScreen.main.bounds.width
fileprivate let SCREEN_HEIGHT = UIScreen.main.bounds.height
fileprivate let STATUES_BAR_HEIGHT: CGFloat = 20.0

fileprivate let ALERT_MARGIN: CGFloat = 40.0
fileprivate let SHEET_MARGIN: CGFloat = 10.0

// MARK: - class BDAlertController
class BDAlertController: UIViewController {
    
    fileprivate var contentEdgeInset: UIEdgeInsets = UIEdgeInsets.zero
    fileprivate var presentAnimator: TransitionAnimator?
    fileprivate var dismissAnimator: TransitionAnimator?
    
    open var contentView: UIView = UIView()
    open var contentFrame = CGRect.zero
    open var couldTouchDissmiss = true
    open var shouldShowOverlay = true
    open var overlayAlpha: CGFloat = 0.5

    // MARK: - Initialization
    convenience init(contentView: UIView, contentFrame: CGRect) {
        self.init()
        self.modalPresentationStyle = .custom
        self.contentFrame = contentFrame
        self.contentView = contentView
    }
    

    convenience init(withSystemModalTransitionType transitionType: UIModalTransitionStyle, contentView: UIView, contentFrame: CGRect) {
        self.init(contentView: contentView, contentFrame: contentFrame)
        self.modalTransitionStyle = transitionType
    }
    
    convenience init(withSystemModalTransitionType transitionType: UIModalTransitionStyle, contentView: UIView, contentEdgeInset: UIEdgeInsets) {
        let tempFrame = CGRect(x: contentEdgeInset.left, y:contentEdgeInset.top, width: SCREEN_WIDTH-contentEdgeInset.left-contentEdgeInset.right, height: SCREEN_HEIGHT-contentEdgeInset.top-contentEdgeInset.bottom)
        self.init(withSystemModalTransitionType: transitionType, contentView: contentView, contentFrame: tempFrame)
        self.contentEdgeInset = contentEdgeInset
    }
    
    convenience init(contentView: UIView, contentFrame: CGRect, presentAnimator: TransitionAnimator, dismissAnimator: TransitionAnimator) {
        self.init(contentView: contentView, contentFrame: contentFrame)
        self.transitioningDelegate = self
        self.presentAnimator = presentAnimator
        self.dismissAnimator = dismissAnimator
    }
    
    convenience init(contentView: UIView, contentEdgeInset: UIEdgeInsets, presentAnimator: TransitionAnimator, dismissAnimator: TransitionAnimator) {
        let tempFrame = CGRect(x: contentEdgeInset.left, y:contentEdgeInset.top, width: SCREEN_WIDTH-contentEdgeInset.left-contentEdgeInset.right, height: SCREEN_HEIGHT-contentEdgeInset.top-contentEdgeInset.bottom)
        self.init(contentView: contentView, contentFrame: tempFrame, presentAnimator: presentAnimator, dismissAnimator: dismissAnimator)
    }
    
    convenience init(withCustomModalTransitionType transitionType: BDCustomModalTransitionStyle, contentView: UIView, contentFrame: CGRect, durarion: TimeInterval) {
        self.init(contentView: contentView, contentFrame: contentFrame, presentAnimator: TransitionAnimatorMaker.presentAnimator(style: transitionType, duration: durarion), dismissAnimator: TransitionAnimatorMaker.dismissAnimator(style: transitionType, duration: durarion))
    }
        
    convenience init(withCustomModalTransitionType transitionType: BDCustomModalTransitionStyle, contentView: UIView, contentEdgeInset: UIEdgeInsets, durarion: TimeInterval) {
        let tempFrame = CGRect(x: contentEdgeInset.left, y:contentEdgeInset.top, width: SCREEN_WIDTH-contentEdgeInset.left-contentEdgeInset.right, height: SCREEN_HEIGHT-contentEdgeInset.top-contentEdgeInset.bottom)
        self.init(withCustomModalTransitionType: transitionType, contentView: contentView, contentFrame: tempFrame, durarion: durarion)
        self.contentEdgeInset = contentEdgeInset
    }
    
    
    // MARK: - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        if shouldShowOverlay {
            view.addSubview(overlayView)
        }
        view.addSubview(contentView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        overlayView.frame = view.bounds
        contentView.frame = contentFrame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Private Methods
    // MARK: - Public Methods
    // MARK: - Event Response
    @objc fileprivate func didTouchOverlayView(_ sender:AnyObject?) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lazy Var
    lazy var overlayView: UIControl = {
        var overlay = UIControl(frame: CGRect.zero)
        overlay.backgroundColor = UIColor.black
        overlay.alpha = self.overlayAlpha
        if self.couldTouchDissmiss {
            overlay.addTarget(self, action: #selector(didTouchOverlayView), for: .touchUpInside)
        }
        return overlay
    }()
}

// MARK: - extension UIViewControllerTransitioningDelegate
extension BDAlertController : UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.presentAnimator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.dismissAnimator
    }
}


