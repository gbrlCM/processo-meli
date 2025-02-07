//
//  HomeCoordinator.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//
import UIKit
import RouterInterface

@MainActor
protocol HomeCoordinatorProtocol {
    func goToSearch(query: String)
    func presentErrorMessage(error: String)
}

final class HomeCoordinator: HomeCoordinatorProtocol {
    weak var navigator: Navigator?
    
    func goToSearch(query: String) {
        guard let searchView = RouterProvider.shared.router?.view(for: SearchRoute(query: query)) else { return }
        navigator?.push(viewController: searchView, animated: true)
    }
    
    func presentErrorMessage(error: String) {
        let alertController = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alertController.addAction(.init(title: "Okay", style: .default))
        navigator?.present(viewController: alertController, animated: true)
    }
}
