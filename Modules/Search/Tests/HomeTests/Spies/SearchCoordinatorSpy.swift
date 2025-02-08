//
//  SearchCoordinatorSpy.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

@testable import Search
import Model

final class SearchCoordinatorSpy: SearchCoordinatorProtocol {
    enum Method: Equatable {
        case goToDetail(ProductDetail)
        case presentSearchError
    }
    
    private(set) var methods: [Method] = []
    
    func goToDetail(_ detail: ProductDetail) {
        methods.append(.goToDetail(detail))
    }
    
    func presentSearchError() {
        methods.append(.presentSearchError)
    }
    
    
}
