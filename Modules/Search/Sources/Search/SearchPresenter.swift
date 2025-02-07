//
//  SearchPresenter.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import Model
import Foundation

@MainActor
protocol SearchPresenterProtocol {
    func loading(isLoading: Bool)
    func updateData(_ data: [ProductDetail], animated: Bool)
}

final class SearchPresenter: SearchPresenterProtocol {
    weak var viewController: (any SearchViewControllerProtocol)?
    
    func updateData(_ data: [ProductDetail], animated: Bool) {
        let viewModels = data.map { product in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.currencyCode = product.currencyId
            numberFormatter.minimumFractionDigits = 2
            let price = numberFormatter.string(for: product.price) ?? ""
            return ProductCellViewModel(name: product.title, price: price, thumbnail: product.thumbnail, id: product.id)
        }
        
        viewController?.updateWithNewData(data: [0: viewModels], animated: animated)
    }
    
    func loading(isLoading: Bool) {
        viewController?.loading(isLoading)
    }
}
