//
//  HomeFactory.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import UIKit

public protocol HomeFactoryProtocol {
    @MainActor func build() -> UIViewController
}

public final class HomeFactory: HomeFactoryProtocol {
    public init() {}
    
    public func build() -> UIViewController {
        let coordinator = HomeCoordinator()
        let interactor = HomeInteractor(coordinator: coordinator)
        let viewController = HomeViewController(interactor: interactor)
        
        coordinator.navigator = viewController
        return viewController
    }
}
