//
//  GeneralInformationCell.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 09/02/25.
//

import UIKit
import SnapKit
import DesignSystem

final class GeneralInformationCell: ConfigurableCell<GeneralInformationView, DetailItem.GeneralInfoViewModel> {}

final class GeneralInformationView: ConfigurableView<DetailItem.GeneralInfoViewModel> {
    private let stack: UIStackView = UIStackView()
    private let nameLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()
    
    override func setupHierarchy() {
        addSubview(stack)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(priceLabel)
        stack.addArrangedSubview(UIView())
    }
    
    override func setupLayout() {
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.md)
        }
    }
    
    override func setupStyle() {
        stack.axis = .vertical
        stack.spacing = Spacing.xSm
        nameLabel.font = .preferredFont(forTextStyle: .body)
        priceLabel.font = .preferredFont(forTextStyle: .title2, compatibleWith: .init(legibilityWeight: .bold))
        nameLabel.textColor = UIColor(named: .secondaryText)
        priceLabel.textColor = UIColor(named: .text)
        nameLabel.numberOfLines = 0
        backgroundColor = UIColor(named: .cellBackground)
    }
    
    override func configure(with viewModel: DetailItem.GeneralInfoViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
