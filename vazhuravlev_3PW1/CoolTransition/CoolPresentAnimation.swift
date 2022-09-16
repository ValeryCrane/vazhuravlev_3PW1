//
//  CoolPresentAnimation.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 16.09.2022.
//

import UIKit

extension CoolPresentAnimation {
    enum Constants {
        static let duration: TimeInterval = 0.5
    }
}

/// Анимация красивого презента из определенного фрейма.
class CoolPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let startFrame: CGRect
    
    init(startFrame: CGRect) {
        self.startFrame = startFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Constants.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.animator(using: transitionContext)
        animator?.startAnimation()
    }
    
    private func animator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating? {
        guard
            let presentedView = transitionContext.view(forKey: .to),
            let presentedViewController = transitionContext.viewController(forKey: .to)
        else {
            return nil
        }
        
        let presentedViewFinalFrame = transitionContext.finalFrame(for: presentedViewController)
        presentedView.frame = startFrame
        let animator = UIViewPropertyAnimator(duration: Constants.duration, curve: .easeOut) {
            presentedView.frame = presentedViewFinalFrame
        }
        animator.addCompletion { position in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
}
