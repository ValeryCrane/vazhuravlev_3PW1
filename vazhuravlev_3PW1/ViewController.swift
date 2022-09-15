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
        static let colorChangeDuration: CGFloat = 1.0
    }
}

class ViewController: UIViewController {
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for view in views {
            view.layer.cornerRadius = Constants.defaultCornerRadius
        }
    }

    @IBAction func changeColorButtonPressed(_ sender: Any) {
        let button = sender as? UIButton
        button?.isEnabled = false
        
        var colorSet = Set<UIColor>()
        while colorSet.count < views.count {
            if let color = UIColor(hexString: createRandomHexColor()) {
                colorSet.insert(color)
            }
        }
        
        UIView.animate(withDuration: Constants.colorChangeDuration, animations: {
            for view in self.views {
                view.backgroundColor = colorSet.popFirst()
            }
        }, completion: { _ in
            button?.isEnabled = true
        })
    }
    
    private func createRandomHexColor() -> String {
        let digits = "0123456789ABCDEF"
        return "#" + String((0..<6).compactMap { _ in digits.randomElement() })
    }
    
}

