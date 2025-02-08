//
//  SearchViewControllerSpy.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

@testable import Search
import DesignSystem
import Model

final class SearchViewControllerSpy: SearchViewControllerProtocol {
    enum Method: Equatable {
        case loading(Bool)
        case updateWithNewData(data: [Int : [ProductCellViewModel]], animated: Bool)
    }
    
    private(set) var methods: [Method] = []
    
    func loading(_ isLoading: Bool) {
        methods.append(.loading(isLoading))
    }
    
    func updateWithNewData(data: [Int : [ProductCellViewModel]], animated: Bool) {
        methods.append(.updateWithNewData(data: data, animated: animated))
    }
}
