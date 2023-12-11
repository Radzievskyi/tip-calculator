//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-11.
//

import Foundation
import Combine

class CalculatorVM {
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPubisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
    }
    
    func transform(input: Input) -> Output {
        let result = Result(
            amountPerPerson: 500,
            totalBill: 1000,
            totalTip: 50.0)
        return Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
    }
    
}
