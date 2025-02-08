//
//  SearchRepositoryTests.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import Network
import NetworkTestHelpers
import Testing
import Foundation

@testable import Search

@Suite("GIVEN a SearchRepository")
struct SearchRepositoryTests {
    let networkSpy: NetworkSpy
    let sut: SearchRepository
    
    init() {
        networkSpy = NetworkSpy()
        sut = SearchRepository(network: networkSpy)
    }
    
    @Test("WHEN search is called THEN it should return the network response")
    func testSearch() async throws {
        let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=query&offset=0")
        
        try #require(url != nil, "URL must be valid")
        
        await networkSpy.registerResponse(
            key: url!,
            SearchResponse.mock()
        )
        
        let response = try await sut.search(query: "query", page: 0)
        
        #expect(response == .mock())
        await #expect(networkSpy.methods == [.fetch(url: url!)])
    }
}
