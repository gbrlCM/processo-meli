//
//  DetailPresenter.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

@MainActor
protocol DetailPresenterProtocol {
    
}

final class DetailPresenter: DetailPresenterProtocol {
    weak var viewController: DetailViewControllerProtocol?
}
