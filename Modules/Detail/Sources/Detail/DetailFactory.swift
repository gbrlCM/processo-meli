//
//  DetailFactory.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//
import UIKit
import Model

@MainActor
public protocol DetailFactoryProtocol {
    func build(_ detail: ProductDetail) -> UIViewController
}

public final class DetailFactory: DetailFactoryProtocol {
    public init() {}
    
    public func build(_ detail: ProductDetail) -> UIViewController {
        let presenter = DetailPresenter()
        let interactor = DetailInteractor(presenter: presenter)
        let viewController = DetailViewController(interactor: interactor)
        presenter.viewController = viewController
        return viewController
    }
}
