//
//  SearchRepositorySpy.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

@testable import Search
import Foundation
import Model

final actor SearchRepositorySpy: SearchRepositoryProtocol {
    enum Method: Equatable {
        case search(query: String, page: Int)
    }
    
    private(set) var methods: [Method] = []
    
    private var searchResponse: SearchResponse?
    func search(query: String, page: Int) async throws -> SearchResponse {
        methods.append(.search(query: query, page: page))
        
        if let searchResponse {
            return searchResponse
        } else {
            throw URLError(.unknown)
        }
    }
    
    func setSearchResponse(with response: SearchResponse?) async {
        searchResponse = response
    }
}
