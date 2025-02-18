//
//  HomeInteractor.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

import Foundation

@MainActor
protocol HomeInteractorProtocol {
    func textValueDidChange(_ value: String)
    func search()
}

final class HomeInteractor: HomeInteractorProtocol {
    private let coordinator: HomeCoordinatorProtocol
    
    private(set) var pageState: State
    
    init(
        coordinator: HomeCoordinatorProtocol,
        state: State = State(query: "")
    ) {
        self.coordinator = coordinator
        self.pageState = state
    }
    
    func textValueDidChange(_ value: String) {
        pageState.query = value
    }
    
    func search() {
        if !pageState.query.isEmpty {
            coordinator.goToSearch(query: pageState.query)
        } else {
            coordinator.presentErrorMessage()
        }
    }
}

extension HomeInteractor {
    struct State: Equatable {
        var query: String
    }
}
