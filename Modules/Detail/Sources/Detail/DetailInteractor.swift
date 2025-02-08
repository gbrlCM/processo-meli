//
//  DetailInteractor.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

@MainActor
protocol DetailInteractorProtocol {
    
}

final class DetailInteractor: DetailInteractorProtocol {
    private let presenter: DetailPresenter
    
    init(presenter: DetailPresenter) {
        self.presenter = presenter
    }
}
