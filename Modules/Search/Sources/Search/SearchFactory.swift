//
//  SearchFactory.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import UIKit
import Network

public protocol SearchFactoryProtocol {
    @MainActor func build() -> UIViewController
}

public final class SearchFactory: SearchFactoryProtocol {
    public init() {}
    
    public func build() -> UIViewController {
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(presenter: presenter, repository: SearchRepository(network: Network()))
        let viewController = SearchViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
