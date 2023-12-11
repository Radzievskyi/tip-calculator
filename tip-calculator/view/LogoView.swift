//
//  LogoView.swift
//  tip-calculator
//
//  Created by Mykhailo Radzievskyi on 2023-12-09.
//

import UIKit

class LogoView: UIView {
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: .init(named: "icCalculatorBW"))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(
            string: "Mr TIP",
            attributes: [
                .font: ThemeFont.demibold(ofsize: 16),
                .foregroundColor: ThemeColor.text
            ])
        text.addAttributes([
            .font: ThemeFont.bold(ofsize: 16)
        ], range: NSMakeRange(3, 3 ))
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: "Caclculator",
            font: ThemeFont.bold(ofsize: 20),
            textAlignment: .left)
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        view.axis = .vertical
        view.spacing = -4
        view.alignment = .center
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            imageView,
            vStackView
        ])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints{
            make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            make in
            make.height.equalTo(imageView.snp.width)
        }
    }
    
}
