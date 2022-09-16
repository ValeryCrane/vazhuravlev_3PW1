//
//  ColorView.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 16.09.2022.
//

import Foundation
import UIKit

/// Вьюха, показывающая некий цвет.
class ColorView: UIView {
    private(set) var colorModel: ColorModel?
    private var tapAction: ((ColorModel?) -> Void)?
    
    /// Подготавливает вьюху и вешвет на нее экшн.
    func setup(with colorModel: ColorModel, tapAction: @escaping (ColorModel?) -> Void) {
        self.backgroundColor = colorModel.color
        self.tapAction = tapAction
        self.colorModel = colorModel
        
        if let gestureRecognizers = gestureRecognizers {
            for gestureRecogniser in gestureRecognizers {
                removeGestureRecognizer(gestureRecogniser)
            }
        }
        
        let tapGestureRcogniser = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGestureRcogniser)
    }
    
    @objc private func didTap(_ sender: Any) {
        tapAction?(colorModel)
    }
}
