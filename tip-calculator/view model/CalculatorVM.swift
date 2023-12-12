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
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resultCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func transform(input: Input) -> Output {
        
//        input.billPublisher.sink { bill in
//            print("The bill: \(bill)")
//        }.store(in: &cancellables)
        
//        input.tipPubisher.sink { tip in
//            print("The tip: \(tip)")
//        }.store(in: &cancellables)
        
//        input.splitPublisher.sink { quantity in
//            print("Qauantity: \(quantity)")
//        }.store(in: &cancellables)
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher
        ).flatMap { [unowned self] (bill, tip, split) in
            let totalTip = getTipAmount(bill: bill, tip: tip)
            let totalBil = bill + totalTip
            let amountPerPerson = totalBil / Double(split)
            
            let result = Result(
                amountPerPerson: amountPerPerson,
                totalBill: totalBil,
                totalTip: totalTip)
            return Just(result)
        }.eraseToAnyPublisher()
        
        let resultCalculatorPublisher = input.logoViewTapPublisher
        
        return Output(updateViewPublisher: updateViewPublisher, resultCalculatorPublisher: resultCalculatorPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPecent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
    
}
