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
        await repositorySpy.setSearchResponse(with: .mock())
        await sut.search(query: "query")
        
        await #expect(repositorySpy.methods == [.search(query: "query", page: 0)])
        #expect(sut.pageState == .init(paging: SearchResponse.mock().paging, shouldLoadMore: true, products: [.mock()]))
    }
    
    @Test("WHEN search is called THEN it should call presenter to set loading, update data and the stop loading")
    func testPresenterCalling() async throws {
        await repositorySpy.setSearchResponse(with: .mock())
        await sut.search(query: "query")
        
        #expect(
            presenterSpy.methods == [.loading(isLoading: true), .loading(isLoading: false), .updateData([.mock()], animated: true)]
        )
    }
    
    @Test("WHEN search is called and it fails THEN it should start loading, stop loading and present error message")
    func testSearchErrorHandling() async throws {
        await sut.search(query: "query")
        
        #expect(coordinatorSpy.methods == [.presentSearchError])
        #expect(presenterSpy.methods == [.loading(isLoading: true), .loading(isLoading: false)])
    }
    
    @Test("WHEN search is called and it fails THEN it should toggle shouldLoadMore to false")
    func testSearchShouldLoadMore() async throws {
        await sut.search(query: "query")
        
        #expect(!sut.pageState.shouldLoadMore)
    }
    
    @Test("WHEN loadMoreElements is called and it succeed THEN it should update the paging and the product details")
    mutating func testLoadMoreItemsSuccess() async throws {
        await repositorySpy.setSearchResponse(with: .mock(paging: .init(total: 100, offset: 10, limit: 10)))
        sut = .init(
            presenter: presenterSpy,
            repository: repositorySpy,
            coordinator: coordinatorSpy,
            state: .init(paging: .init(total: 100, offset: 0, limit: 10), shouldLoadMore: true, products: [.mock()])
        )
        
        let expectedNewState = SearchInteractor.State(paging: .init(total: 100, offset: 10, limit: 10), products: [.mock(), .mock()])
        
        await sut.loadMoreElements(query: "query")
        
        await #expect(repositorySpy.methods == [.search(query: "query", page: 10)])
        #expect(sut.pageState == expectedNewState)
    }
    
    @Test("WHEN loadMoreElements is called and it succeed THEN it should call presenter to update the screen")
    mutating func testLoadMoreItemSuccessPresentCalls() async throws {
        await repositorySpy.setSearchResponse(with: .mock(paging: .init(total: 100, offset: 10, limit: 10)))
        sut = .init(
            presenter: presenterSpy,
            repository: repositorySpy,
            coordinator: coordinatorSpy,
            state: .init(paging: .init(total: 100, offset: 0, limit: 10), shouldLoadMore: true, products: [.mock()])
        )
        
        await sut.loadMoreElements(query: "query")
        
        #expect(
            presenterSpy.methods == [.loading(isLoading: false), .updateData([.mock(), .mock()], animated: true)]
        )
    }
    
    @Test("WHEN loadMoreElements is called and shouldLoadMore is false THEN it should no execute the query")
    mutating func testLoadMoreItemShouldLoadMoreOff() async throws {
        await repositorySpy.setSearchResponse(with: .mock(paging: .init(total: 100, offset: 10, limit: 10)))
        sut = .init(
            presenter: presenterSpy,
            repository: repositorySpy,
            coordinator: coordinatorSpy,
            state: .init(paging: .init(total: 100, offset: 0, limit: 10), shouldLoadMore: false, products: [.mock()])
        )
        
        let expectedNewState = SearchInteractor.State(paging: .init(total: 100, offset: 0, limit: 10), shouldLoadMore: false, products: [.mock()])
        
        await sut.loadMoreElements(query: "query")
        
        await #expect(repositorySpy.methods.isEmpty)
        #expect(sut.pageState == expectedNewState)
    }
    
    @Test("WHEN selectedElements is called with a valid index THEN it should call coordinator to navigate to detail")
    mutating func testSelectedElementsSucces() async throws {
        sut = .init(
            presenter: presenterSpy,
            repository: repositorySpy,
            coordinator: coordinatorSpy,
            state: .init(products: [.mock()])
        )
        
        sut.selectedProduct(at: 0)
        #expect(coordinatorSpy.methods == [.goToDetail(.mock())])
    }
    
    @Test("WHEN selectedElements is called with a inValid index THEN it should not call coordinator to navigate to detail")
    mutating func testSelectedElementsFail() async throws {
        sut = .init(
            presenter: presenterSpy,
            repository: repositorySpy,
            coordinator: coordinatorSpy,
            state: .init(products: [.mock()])
        )
        
        sut.selectedProduct(at: 1000)
        #expect(coordinatorSpy.methods == [])
    }
}
