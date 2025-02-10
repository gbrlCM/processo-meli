//
//  DetailInteractor.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//
import Model

@MainActor
protocol DetailInteractorProtocol {
    func loadDetail() async
}

final class DetailInteractor: DetailInteractorProtocol {
    private let presenter: DetailPresenterProtocol
    
    private(set) var pageState: State
    
    init(presenter: DetailPresenterProtocol, state: State) {
        self.presenter = presenter
        self.pageState = state
    }
    
    func loadDetail() async {
        await presenter.presentDetail(pageState.detail)
    }
    
}

extension DetailInteractor {
    struct State: Equatable {
        let detail: ProductDetail
    }
}
