//
//  SearchInteractor.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import Foundation
import Model

@MainActor
protocol SearchInteractorProtocol {
    func search(query: String) async
    func loadMoreElements(query: String) async
}

final class SearchInteractor: SearchInteractorProtocol {
    private let presenter: SearchPresenterProtocol
    private let repository: SearchRepositoryProtocol
    
    private var pageState: State
    
    init (presenter: SearchPresenterProtocol, repository: SearchRepositoryProtocol) {
        self.presenter = presenter
        self.repository = repository
        self.pageState = State()
    }
    
    func search(query: String) async {
        await MainActor.run {
            presenter.loading(isLoading: true)
        }
        self.pageState.paging = .init(total: 0, offset: 0, limit: 0)
        self.pageState.products = []
        await executeSearch(query: query, animated: true)
    }
    
    func loadMoreElements(query: String) async {
        guard pageState.shouldLoadMore else { return }
        await executeSearch(query: query, animated: true)
    }
    
    private func executeSearch(query: String, animated: Bool) async {
        do {
            let products = try await self.repository.search(
                query: query,
                page: self.pageState.paging.page
            )
            
            await MainActor.run {
                self.presenter.loading(isLoading: false)
                self.pageState.shouldLoadMore = !products.results.isEmpty
                self.pageState.products.append(contentsOf: products.results)
                self.presenter.updateData(pageState.products, animated: animated)
                self.pageState.paging = products.paging
                print(pageState.paging, pageState.shouldLoadMore)
            }
        } catch {
            
        }
    }
}

extension SearchInteractor {
    struct State: Equatable {
        var paging: SearchResponse.Paging = .init(total: 0, offset: 0, limit: 0)
        var shouldLoadMore: Bool = true
        var products: [ProductDetail] = []
    }
}
