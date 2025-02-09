//
//  DetailPresenter.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//
import Network
import Model
import DesignSystem
import UIKit

@MainActor
protocol DetailPresenterProtocol {
    func presentDetail(_ detail: ProductDetail) async
}

final class DetailPresenter: DetailPresenterProtocol {
    private typealias Section = CollectionViewSection<DetailSection, DetailItem>
    
    private let imageProvider: ImageRepositoryProtocol
    private lazy var formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }()
    
    weak var viewController: (any DetailViewControllerProtocol)?
    
    init(imageProvider: ImageRepositoryProtocol = ImageRepository.shared) {
        self.imageProvider = imageProvider
    }
    
    func presentDetail(_ detail: ProductDetail) async {
        viewController?.loading(true)
        
        let sections = await buildSections(for: detail)
        
        viewController?.updateWithNewData(data: sections, animated: true)
        viewController?.loading(false)
    }
    
    private func buildSections(for detail: ProductDetail) async -> [Section] {
        var sections: [Section] = []
        
        await sections.append(buildImageSection(for: detail))
        sections.append(buildListSection(for: detail))
        sections.append(buildAttributeSection(for: detail.attributes))
        
        return sections
    }
    
    private func buildListSection(for detail: ProductDetail) -> Section {
        var items: [DetailItem] = []
        formatter.currencyCode = detail.currencyId
        let price = formatter.string(for: detail.price) ?? "\(detail.price)"
        items.append(.generalInfo(.init(name: detail.title, price: price)))
        
        if detail.shipping.freeShipping {
            items.append(.perk(.init(icon: UIImage(systemName: "shippingbox.fill"), value: "Frete Gratis!")))
        }
        
        if detail.acceptsMercadopago {
            items.append(.perk(.init(icon: UIImage(systemName: "creditcard.fill"), value: "Pagamento com Mercado Pago")))
        }
        return Section(sectionType: .list, items: items)
    }
    
    private func buildImageSection(for detail: ProductDetail) async -> Section {
        let url = ImageUrlBuilder.build(for: detail.thumbnailId) ?? detail.thumbnail
        let image = await imageProvider.fetch(from: url)
        let item: DetailItem
        
        if let image {
            item = .image(image)
        } else {
            let lowQualityImage = await imageProvider.fetch(from: detail.thumbnail) ?? UIImage(systemName: "x.circle")
            item = .image(lowQualityImage)
        }
        
        return  Section(sectionType: .presentation, items: [item])
    }
    
    private func buildAttributeSection(for attributes: [ProductDetail.Attributes]) -> Section {
        let viewModels = attributes.compactMap { attribute -> DetailItem? in
            guard let valueName = attribute.valueName else { return nil }
            return DetailItem.attribute(.init(name: attribute.name, value: valueName))
        }
        return Section(sectionType: .attributes, items: viewModels)
    }
}
