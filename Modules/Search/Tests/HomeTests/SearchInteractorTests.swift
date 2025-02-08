//
//  SearchInteractorTests.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

import Testing
import Model
import Foundation
@testable import Search

@Suite("GIVEN a SearchInteractor")
@MainActor
struct SearchInteractorTests {
    var sut: SearchInteractor
    var coordinatorSpy: SearchCoordinatorSpy
    var presenterSpy: SearchPresenterSpy
    var repositorySpy: SearchRepositorySpy
    
    init() {
        repositorySpy = SearchRepositorySpy()
        presenterSpy = SearchPresenterSpy()
        coordinatorSpy = SearchCoordinatorSpy()
        sut = SearchInteractor(presenter: presenterSpy, repository: repositorySpy, coordinator: coordinatorSpy)
    }
    
    @Test("WHEN search is called THEN it should update the state with the repository response")
    func testSearchStateUpdate() async throws {
        await setupRepositorySpy()
        await sut.search(query: "query")
        
        await #expect(repositorySpy.methods == [.search(query: "query", page: 0)])
        #expect(sut.pageState == .init(paging: SearchResponse.mock.paging, shouldLoadMore: true, products: SearchResponse.mock.results))
    }
    
    @Test("WHEN search is called THEN it should call presenter to set loading, update data and the stop loading")
    func testPresenterCalling() async throws {
        await setupRepositorySpy()
        await sut.search(query: "query")
        
        #expect(
            presenterSpy.methods == [.loading(isLoading: true), .loading(isLoading: false), .updateData(SearchResponse.mock.results, animated: true)]
        )
    }
    
    @Test("WHEN search is called and it fails THEN it should start loading, stop loading and present error message")
    func testSearchErrorHandling() async throws {
        await sut.search(query: "query")
        
        await #expect(repositorySpy.methods == [.search(query: "query", page: 0)])
        #expect(coordinatorSpy.methods == [.presentSearchError])
        #expect(presenterSpy.methods == [.loading(isLoading: true), .loading(isLoading: false)])
        #expect(!sut.pageState.shouldLoadMore)
    }
    
    private func setupRepositorySpy() async {
        let expectedResponse: SearchResponse = .mock
        await repositorySpy.setSearchResponse(with: expectedResponse)
    }
}
