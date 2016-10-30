//
//  SlideRightTransitionAnimator.swift
//  PiSay
//
//  Created by 鎮魁 on 2016/10/6.
//  Copyright © 2016年 AppDevelopment. All rights reserved.
//

import UIKit

class SlideRightTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var duration = 0.05
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        //取得 fromView、toView 以及 container view 的參照
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        //設定我們會用在動畫中的變換（transform）
        let container = transitionContext.containerView
        
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
   //   let offScreenRight = CGAffineTransformMakeTranslation(container!.frame.width, 0)
        
        //讓 toView 離開畫面
        if isPresenting {
            toView.transform = offScreenLeft
        }
        
        //將兩個視圖加進容器視圖
        if isPresenting {
            container.addSubview(fromView)
            container.addSubview(toView)
        }
        else {
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        
        //執行動畫
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: UIViewAnimationOptions(), animations: {
            
            if self.isPresenting{
                toView.transform = CGAffineTransform.identity
            } else {
                fromView.transform = offScreenLeft
            }
            
            }, completion: { finished in transitionContext.completeTransition(true)})
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    
    }

}
