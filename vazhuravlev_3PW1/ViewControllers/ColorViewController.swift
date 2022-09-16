//
//  ColorViewController.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 16.09.2022.
//

import UIKit

extension ColorViewController {
    private enum Constants {
        static let textAlphaAnimationDuration = 0.3
    }
}

/// Контроллер, отображающий информацию о каком-либо цвете.
class ColorViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.alpha = 0.0
        aboutTextView.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: animated ? Constants.textAlphaAnimationDuration : 0.0) {
            self.titleLabel.alpha = 1.0
            self.aboutTextView.alpha = 1.0
        }
    }
    
    func setup(with colorModel: ColorModel) {
        view.backgroundColor = colorModel.color
        titleLabel.text = colorModel.title
        aboutTextView.text = colorModel.about
    }
}

extension ColorViewController: PreparableForDismiss {
    func prepareForDismiss(animated: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: animated ? Constants.textAlphaAnimationDuration : 0.0, animations: {
            self.titleLabel.alpha = 0.0
            self.aboutTextView.alpha = 0.0
        }, completion: { _ in
            completion?()
        })
    }
}
