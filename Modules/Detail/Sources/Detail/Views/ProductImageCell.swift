//
//  ProductImageCell.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 09/02/25.
//

import UIKit
import SnapKit
import DesignSystem

final class ProductImageCell: ConfigurableCell<ProductImage, UIImage?> {}

final class ProductImage: ConfigurableView<UIImage?> {
    private let imageView: UIImageView = UIImageView()
    
    override func setupHierarchy() {
        addSubview(imageView)
    }
    
    override func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Spacing.sm)
        }
    }
    
    override func setupStyle() {
        imageView.contentMode = .scaleAspectFit
        backgroundColor = .white
    }
    
    override func configure(with viewModel: UIImage?) {
        imageView.image = viewModel
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
