//
//  SearchRepository.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

import Network
import Model
import Foundation


protocol SearchRepositoryProtocol: AnyObject, Actor {
    func search(query: String, page: Int) async throws -> SearchResponse
}

final actor SearchRepository: SearchRepositoryProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func search(query: String, page: Int) async throws -> SearchResponse {
        guard let url = searchURL(query: query, page: page) else { throw URLError.init(.badURL) }
        let (data, _): (SearchResponse, URLResponse) = try await network.fetch(from: url)
        return data
    }
    
    private func searchURL(query: String, page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.mercadolibre.com"
        components.path = "/sites/MLA/search"
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "offset", value: String(page))
        ]
        print(components.url)
        return components.url
    }
}
