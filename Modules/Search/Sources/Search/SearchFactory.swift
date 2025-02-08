//
//  SearchFactory.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import UIKit
import Network
import RouterInterface

@MainActor
public protocol SearchFactoryProtocol {
    func build(query: String) -> UIViewController
}

public final class SearchFactory: SearchFactoryProtocol {
    let router: RouterProtocol
    let network: NetworkProtocol
    
    public init(router: RouterProtocol, network: NetworkProtocol) {
        self.router = router
        self.network = network
    }
    
    public func build(query: String) -> UIViewController {
        let presenter = SearchPresenter()
        let coordinator = SearchCoordinator(router: router)
        let interactor = SearchInteractor(
            presenter: presenter,
            repository: SearchRepository(network: network),
            coordinator: coordinator
        )
        let viewController = SearchViewController(interactor: interactor, initialQuery: query)
        presenter.viewController = viewController
        coordinator.navigator = viewController
        return viewController
    }
}
