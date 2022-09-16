//
//  PreparableForDismiss.swift
//  vazhuravlev_3PW1
//
//  Created by valeriy.zhuravlev on 16.09.2022.
//

import UIKit

/// Протокол контроллеров, которые нужно подготовить к скрытию.
protocol PreparableForDismiss: UIViewController {
    func prepareForDismiss(animated: Bool, completion: (() -> Void)?)
}
