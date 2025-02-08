//
//  SearchPresenterSpy.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

@testable import Search
import Model

final class SearchPresenterSpy: SearchPresenterProtocol {
    enum Method: Equatable {
        case loading(isLoading: Bool)
        case updateData([ProductDetail], animated: Bool)
    }
    
    private(set) var methods: [Method] = []
    
    func loading(isLoading: Bool) {
        methods.append(.loading(isLoading: isLoading))
    }
    
    func updateData(_ data: [ProductDetail], animated: Bool) {
        methods.append(.updateData(data, animated: animated))
    }
}
