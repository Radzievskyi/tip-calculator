//
//  Double+Extension.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-12.
//

import Foundation

extension Double {
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true: !isNormal ? false: self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
