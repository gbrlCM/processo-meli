//
//  HomeCoordinatorSpy.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//
@testable import Home

final class HomeCoordinatorSpy: HomeCoordinatorProtocol {
    enum Method: Equatable {
        case goToSearch(query: String)
        case presentErrorMessage
    }
    
    private(set) var methods: [Method] = []
    
    func goToSearch(query: String) {
        methods.append(.goToSearch(query: query))
    }
    
    func presentErrorMessage() {
        methods.append(.presentErrorMessage)
    }
}
