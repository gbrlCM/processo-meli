//
//  SearchPresenter.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import Model
import Foundation
import DesignSystem

@MainActor
protocol SearchPresenterProtocol {
    func loading(isLoading: Bool)
    func updateData(_ data: [ProductDetail], animated: Bool)
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var viewController: (any SearchViewControllerProtocol)?
    
    private lazy var formatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter
    }()
    
    func updateData(_ data: [ProductDetail], animated: Bool) {
        let viewModels = data.map(adapt(detail:))
        viewController?.updateWithNewData(data: [CollectionViewSection(sectionType: 0, items: viewModels)], animated: animated)
    }
    
    private func adapt(detail: ProductDetail) -> ProductCellViewModel {
        formatter.currencyCode = detail.currencyId
        let price = formatter.string(for: detail.price) ?? ""
        return ProductCellViewModel(name: detail.title, price: price, thumbnail: detail.thumbnail, id: detail.id)
    }
    
    func loading(isLoading: Bool) {
        viewController?.loading(isLoading)
    }
}
