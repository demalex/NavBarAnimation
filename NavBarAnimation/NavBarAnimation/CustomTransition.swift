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
    
    init(duration: TimeInterval = 1.0, isPresenting: Bool) {
        self.duration = duration
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from),
            let toView = transitionContext.view(forKey: .to),
            let fromView = transitionContext.view(forKey: .from)
        else {
            return
        }
        
        let rightTranslation = CGAffineTransform(translationX: container.frame.width, y: 0)
        let leftTranslation = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        toView.transform = isPresenting ? rightTranslation : leftTranslation
        
        container.addSubview(toView)
        container.addSubview(fromView)
        
        fromVC.navigationController?.navigationBar.backgroundColor = .clear
        fromVC.navigationController?.navigationBar.setBackgroundImage(UIImage.fromColor(color: .clear), for: .default)
        
        UIView.animate(
            withDuration: self.duration,
            animations: {
                fromVC.view.transform = self.isPresenting ? leftTranslation :rightTranslation
                toVC.view.transform = .identity
            },
            completion: { _ in
                fromView.transform = .identity
                toVC.navigationController?.navigationBar.setBackgroundImage(
                    UIImage.fromColor(color: self.isPresenting ? .yellow : .lightGray),
                    for: .default
                )
                transitionContext.completeTransition(true)
            }
        )
    }
}
