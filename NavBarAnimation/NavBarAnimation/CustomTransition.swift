//
//  CustomTransition.swift
//  NavBarAnimation
//
//  Created by Tomasz Pietrowski on 16/01/2018.
//  Copyright © 2018 Tomasz Pietrowski. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning {
  
  private let duration: TimeInterval
  private let isPresenting: Bool
  
  init(duration: TimeInterval = 0.3, isPresenting: Bool) {
    self.duration = duration
    self.isPresenting = isPresenting
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if self.isPresenting {
      self.animatePush(transitionContext)
    } else {
      self.animatePop(transitionContext)
    }
  }
  
  func animatePush(_ transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView
    
    guard let toVC = transitionContext.viewController(forKey: .to),
      let toView = transitionContext.view(forKey: .to) else {
        return
    }
    
    let toViewFinalFrame = transitionContext.finalFrame(for: toVC)
    toView.frame = toViewFinalFrame
    container.addSubview(toView)
    
    let navBarTransition = self.navigationbarTransitionAnimation()
    
    let viewTransition = CABasicAnimation(keyPath: "transform")
    viewTransition.duration = CFTimeInterval(self.duration)
    viewTransition.fromValue = CATransform3DTranslate(toView.layer.transform, container.layer.bounds.width, 0, 0)
    viewTransition.toValue = CATransform3DIdentity
    viewTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    
    self.beginLayerAnimations({
      let imageView = toVC.navigationController?.navigationBar.subviews[0]
      imageView?.layer.add(navBarTransition, forKey: nil)
      toView.layer.add(viewTransition, forKey: nil)
    }) {
      let cancelled = transitionContext.transitionWasCancelled
      if cancelled {
        toView.removeFromSuperview()
      }
      transitionContext.completeTransition(cancelled == false)
    }
  }
  
  func animatePop(_ transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView
    
    guard let toVC = transitionContext.viewController(forKey: .to),
      let toView = transitionContext.view(forKey: .to) else {
        return
    }
    
    let toViewFinalFrame = transitionContext.finalFrame(for: toVC)
    
    toView.frame = toViewFinalFrame
    
    container.addSubview(toView)
    container.sendSubview(toBack: toView)
    
    let fromVC = transitionContext.viewController(forKey: .from)
    let fromView = transitionContext.view(forKey: .from)
    
    let fromViewInitialFrame: CGRect
    if let fromWrapped = fromVC {
      fromViewInitialFrame = transitionContext.initialFrame(for: fromWrapped)
    } else {
      fromViewInitialFrame = CGRect.zero
    }
    
    var fromViewFinalTransform = CATransform3DIdentity
    if let fromViewWrapped = fromView {
      fromViewWrapped.frame = fromViewInitialFrame
      fromViewFinalTransform = CATransform3DTranslate(fromViewWrapped.layer.transform, container.layer.bounds.width, 0, 0)
      fromViewWrapped.layer.transform = fromViewFinalTransform
    }
    
    let navBarTransition = self.navigationbarTransitionAnimation()
    
    let viewTransition = CABasicAnimation(keyPath: "transform")
    viewTransition.duration = CFTimeInterval(self.duration)
    viewTransition.fromValue = CATransform3DIdentity
    viewTransition.toValue = fromViewFinalTransform
    viewTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)

    self.beginLayerAnimations({
      let imageView = toVC.navigationController?.navigationBar.subviews[0]
      imageView?.layer.add(navBarTransition, forKey: nil)
      fromView?.layer.add(viewTransition, forKey: nil)
    }) {
      let cancelled = transitionContext.transitionWasCancelled
      if cancelled {
        toView.removeFromSuperview()
      }
      transitionContext.completeTransition(cancelled == false)
    }
  }
  
  func beginLayerAnimations(_ animations: () -> Void, _ completion: @escaping () -> Void) {
    CATransaction.begin()
    CATransaction.setAnimationDuration(CFTimeInterval(self.duration))
    CATransaction.setCompletionBlock(completion)
    animations()
    CATransaction.commit()
  }
  
  func navigationbarTransitionAnimation() -> CATransition {
    let transition = CATransition()
    transition.duration = CFTimeInterval(self.duration)
    transition.type = kCATransitionPush
    transition.subtype = self.isPresenting ? kCATransitionFromRight : kCATransitionFromLeft
    transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    return transition
  }
}
