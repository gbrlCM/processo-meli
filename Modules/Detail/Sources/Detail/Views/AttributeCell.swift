//
//  AttributeCell.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 09/02/25.
//

import UIKit
import SnapKit
import DesignSystem

final class AttributeCell: ConfigurableCell<AttributeView, DetailItem.AttributeViewModel> {}

final class AttributeView: ConfigurableView<DetailItem.AttributeViewModel> {
    private let stack: UIStackView = UIStackView()
    private let nameLabel: UILabel = UILabel()
    private let valueLabel: UILabel = UILabel()
    
    override func setupHierarchy() {
        addSubview(stack)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(valueLabel)
    }
    
    override func setupLayout() {
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.md)
        }
    }
    
    override func setupStyle() {
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.spacing = Spacing.xSm
        nameLabel.font = .preferredFont(forTextStyle: .subheadline)
        valueLabel.font = .preferredFont(forTextStyle: .headline)
        nameLabel.textColor = UIColor(named: .secondaryText)
        valueLabel.textColor = UIColor(named: .text)
        nameLabel.textAlignment = .center
        valueLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        valueLabel.numberOfLines = 0
        backgroundColor = UIColor(named: .cellBackground)
        layer.cornerRadius = CornerRadius.md
    }
    
    override func configure(with viewModel: DetailItem.AttributeViewModel) {
        nameLabel.text = viewModel.name
        valueLabel.text = viewModel.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
