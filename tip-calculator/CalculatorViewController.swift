//
//  ViewController.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-09.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class CalculatorViewController: UIViewController {
    
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInputView = TipInputView()
    private let splitInputView = SplitInputView()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView,
            UIView()
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    private let viewModel = CalculatorVM()
    private var cancellables = Set<AnyCancellable>()

    private lazy var viewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    private lazy var logoViewTapPublisher: AnyPublisher<Void, Never> = {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.numberOfTapsRequired = 2
        view.addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher.flatMap { _ in
            Just(())
        }.eraseToAnyPublisher()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
        observe()
    }
    
    private func bind() {
        
//        billInputView.valuePublisher.sink { bill in
//            print("bill: \(bill)")
//        }.store(in: &cancellables)
        
        let input = CalculatorVM.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher: tipInputView.valuePublisher,
            splitPublisher: splitInputView.valuePublisher)
        
        let output = viewModel.transform(input: input)
        
        output.updateViewPublisher.sink { [unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
    }
    
    private func observe() {
        viewTapPublisher.sink { [unowned self] value in
            view.endEditing(true)
        }.store(in: &cancellables)
        
        logoViewTapPublisher.sink { _ in
            print("Double tap")
        }.store(in: &cancellables)
    }
    
    private func layout() {
        view.backgroundColor = ThemeColor.background
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints{ make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
            
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
            
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
            
        }
        
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56 + 56 + 16)
            
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
            
        }
    }

}

