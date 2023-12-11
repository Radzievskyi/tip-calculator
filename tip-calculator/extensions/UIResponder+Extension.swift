//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-11.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
