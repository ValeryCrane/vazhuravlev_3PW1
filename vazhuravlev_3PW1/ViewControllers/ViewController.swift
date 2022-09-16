//
//  ViewController.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 15.09.2022.
//

import UIKit

extension ViewController {
    private enum Constants {
        static let defaultCornerRadius: CGFloat = 10.0
        static let colorChangeDuration: TimeInterval = 1.0
    }
}

/// Главный контроллев в проекте.
class ViewController: UIViewController {
    @IBOutlet var views: [ColorView]!
    
    private var colorViewControllerTransition: CoolTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in views {
            view.layer.cornerRadius = Constants.defaultCornerRadius
        }
        changeViewColors(animated: false, completion: nil)
    }

    @IBAction func changeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        
        changeViewColors(animated: true) { [weak button] in
            button?.isEnabled = true
        }
    }
    
    /// Меняет цвета у вьюшек.
    private func changeViewColors(animated: Bool, completion: (() -> Void)?) {
        var colorSet = Set<ColorModel>()
        while colorSet.count < views.count {
            let colorModel = ColorModel.colorModels.randomElement() ?? .black
            colorSet.insert(colorModel)
        }
        
        UIView.animate(withDuration: animated ? Constants.colorChangeDuration : 0.0, animations: {
            for view in self.views {
                view.setup(with: colorSet.popFirst() ?? .black, tapAction: { [weak self] colorModel in
                    self?.presentColorController(with: colorModel ?? .black, from: view)
                })
            }
        }, completion: { _ in
            completion?()
        })
    }
    
    /// Презенутует соответствующий цвету контроллер.
    private func presentColorController(with colorModel: ColorModel, from view: UIView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let colorViewController = storyboard.instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        colorViewController.modalPresentationStyle = .custom
        colorViewControllerTransition = CoolTransition(with: view.frame)
        colorViewController.transitioningDelegate = colorViewControllerTransition
        colorViewController.view.layer.cornerRadius = Constants.defaultCornerRadius
        colorViewController.setup(with: colorModel)
        present(colorViewController, animated: true)
    }
}

