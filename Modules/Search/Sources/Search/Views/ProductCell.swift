//
//  ProductCell.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//

import SnapKit
import UIKit
import DesignSystem
import Network

final class ProductCell: ConfigurableCell<ProductView, ProductCellViewModel> {}

final class ProductView: ConfigurableView<ProductCellViewModel> {
    private let image: UIImageView = UIImageView()
    private let productName: UILabel = UILabel()
    private let productPrice: UILabel = UILabel()
    private let stack: UIStackView = UIStackView()
    private let textStack: UIStackView = UIStackView()
    private let disclosureIndicator: UIImageView = UIImageView()
    
    override func setupHierarchy() {
        addSubview(stack)
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(textStack)
        stack.addArrangedSubview(UIView())
        stack.addArrangedSubview(disclosureIndicator)
        textStack.addArrangedSubview(productName)
        textStack.addArrangedSubview(productPrice)
        textStack.addArrangedSubview(UIView())
    }
    
    override func setupLayout() {
        stack.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(Spacing.md)
        }
        
        image.snp.makeConstraints { make in
            make.width.equalTo(90)
        }
    }
    
    override func setupStyle() {
        stack.axis = .horizontal
        image.contentMode = .scaleAspectFit
        stack.setCustomSpacing(Spacing.sm, after: image)
        productName.font = .preferredFont(forTextStyle: .subheadline)
        productName.textColor = UIColor(named: .secondaryText)
        productPrice.font = .preferredFont(forTextStyle: .body, compatibleWith: .init(legibilityWeight: .bold))
        productPrice.textColor = UIColor(named: .text)
        productName.numberOfLines = 2
        productPrice.numberOfLines = 1
        backgroundColor = UIColor(named: Colors.cellBackground)
        textStack.axis = .vertical
        textStack.spacing = Spacing.sm
        layer.cornerRadius = CornerRadius.md
        let configuration = UIImage.SymbolConfiguration(paletteColors: [UIColor(named: .secondaryAccent)])
        stack.spacing = Spacing.xSm
        
        disclosureIndicator.image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        disclosureIndicator.contentMode = .scaleAspectFit
    }
    
    override func configure(with viewModel: ProductCellViewModel) {
        productName.text = viewModel.name
        productPrice.text = viewModel.price
        
        Task {
            let downloadedImage = await ImageRepository.shared.fetch(from: viewModel.thumbnail)
            image.image = downloadedImage
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
}

struct ProductCellViewModel: Equatable, Hashable {
    let name: String
    let price: String
    let thumbnail: URL
    let id: String
}
