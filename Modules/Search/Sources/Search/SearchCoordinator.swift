//
//  SearchCoordinator.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//
import RouterInterface
import Model
import UIKit

@MainActor
protocol SearchCoordinatorProtocol {
    func goToDetail(_ detail: ProductDetail)
    func presentSearchError()
}

final class SearchCoordinator: SearchCoordinatorProtocol {
    weak var navigator: Navigator?
    
    private let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func goToDetail(_ detail: ProductDetail) {
        guard let detailView = router.view(for: DetailRoute(detail: detail)) else { return }
        navigator?.push(viewController: detailView, animated: true)
    }
    
    func presentSearchError() {
        let alertController = UIAlertController(title: nil, message: L10n.Error.message, preferredStyle: .alert)
        alertController.addAction(.init(title: L10n.Error.button, style: .default))
        navigator?.present(viewController: alertController, animated: true)
    }
}
