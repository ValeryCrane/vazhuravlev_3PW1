//
//  CoolPresentationController.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 16.09.2022.
//

import UIKit

extension CoolPresentationController {
    enum Constants {
        static let viewInsets: UIEdgeInsets = .init(top: 75.0, left: 15.0, bottom: 75.0, right: 15.0)
        static let dimmViewAlpha: CGFloat = 0.5
    }
}

/// Класс, крассиво расставляющий вьюхи для балдежной анимации презента/дисмисса.
class CoolPresentationController: UIPresentationController {
    
    private let dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        
        let safeAreaInsets = containerView.superview?.safeAreaInsets ?? .zero
        let viewInsets = Constants.viewInsets
        
        return .init(
            x: viewInsets.left + safeAreaInsets.left,
            y: viewInsets.top + safeAreaInsets.top,
            width: containerView.bounds.width - viewInsets.left - viewInsets.right - safeAreaInsets.left - safeAreaInsets.right,
            height: containerView.bounds.height - viewInsets.top - viewInsets.bottom - safeAreaInsets.top - safeAreaInsets.bottom
        )
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        containerView?.addSubview(dimmView)
        performAlongsideTransitionIfPossible { [weak self] in
            self?.dimmView.alpha = Constants.dimmViewAlpha
            
        }
        if let presentedView = presentedView {
            containerView?.addSubview(presentedView)
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        
        if !completed {
            dimmView.removeFromSuperview()
        }
        
        let tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(dismissViewController))
        dimmView.addGestureRecognizer(tapGestureRecogniser)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 0.0
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            dimmView.removeFromSuperview()
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        if !presentedViewController.isBeingDismissed {
            presentedView?.frame = frameOfPresentedViewInContainerView
            dimmView.frame = containerView?.bounds ?? .zero
        }
    }
    
    private func performAlongsideTransitionIfPossible(_ transition: @escaping () -> Void) {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            transition()
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            transition()
        }, completion: nil)
    }
    
    @objc private func dismissViewController() {
        if let preparableController = presentedViewController as? PreparableForDismiss {
            preparableController.prepareForDismiss(animated: true) {
                preparableController.dismiss(animated: true)
            }
        } else {
            presentedViewController.dismiss(animated: true)
        }
    }
}
