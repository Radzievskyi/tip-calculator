//
//  Tip.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-11.
//

import Foundation

enum Tip {
    case none
    case tenPecent
    case fifteenPercent
    case twentyPercent
    case custom(value: Int)
    
    var stringvalue: String {
        switch self {
        case .none:
            return ""
        case .tenPecent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(let value):
            return  String(value)
        }
    }
}
