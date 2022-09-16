//
//  CoolTransition.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 16.09.2022.
//

import UIKit

/// Крутой транзишн из определенного фрейма!!!!
class CoolTransition: NSObject, UIViewControllerTransitioningDelegate {
    private let initialFrame: CGRect
    
    init(with initialFrame: CGRect) {
        self.initialFrame = initialFrame
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CoolPresentationController(presentedViewController: presented, presenting: presenting ?? source)
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CoolPresentAnimation(startFrame: initialFrame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CoolDismissAnimation(finalFrame: initialFrame)
    }
}
