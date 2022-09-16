//
//  CoolDismissAnimation.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 16.09.2022.
//

import UIKit

extension CoolDismissAnimation {
    enum Constants {
        static let duration: TimeInterval = 0.5
    }
}

/// Анимация красивого дисмисса в определенный фрейм.
class CoolDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    private let finalFrame: CGRect
    
    init(finalFrame: CGRect) {
        self.finalFrame = finalFrame
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
            let presentedView = transitionContext.view(forKey: .from)
        else {
            return nil
        }
        
        let animator = UIViewPropertyAnimator(duration: Constants.duration, curve: .easeOut) {
            presentedView.frame = self.finalFrame
        }
        animator.addCompletion { position in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        return animator
    }
}
