//
//  HomeFactory.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import UIKit
import RouterInterface

public protocol HomeFactoryProtocol {
    @MainActor func build() -> UIViewController
}

public final class HomeFactory: HomeFactoryProtocol {
    private let router: RouterProtocol
    
    public init(router: RouterProtocol) {
        self.router = router
    }
    
    public func build() -> UIViewController {
        let coordinator = HomeCoordinator(router: router)
        let interactor = HomeInteractor(coordinator: coordinator)
        let viewController = HomeViewController(interactor: interactor)
        
        coordinator.navigator = viewController
        return viewController
    }
}
