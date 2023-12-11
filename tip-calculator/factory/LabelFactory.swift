//
//  LabelFactory.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-11.
//

import UIKit

struct LabelFactory {
    static func build(
        text: String?,
        font: UIFont,
        backroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.text,
        textAlignment: NSTextAlignment = .center) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = font
            label.backgroundColor = backroundColor
            label.textColor = textColor
            label.textAlignment = textAlignment
            return label
        }
}
