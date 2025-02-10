//
//  DetailViewControllerSpy.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/25.
//

import DesignSystem
import Model
@testable import Detail

final class DetailViewControllerSpy: DetailViewControllerProtocol {
    enum Method: Equatable {
        case loading(Bool)
        case updateWithNewData(data: [CollectionViewSection<DetailSection, DetailItem>], animated: Bool)
    }
    
    private(set) var methods: [Method] = []
    
    func loading(_ isLoading: Bool) {
        methods.append(.loading(isLoading))
    }
    
    func updateWithNewData(data: [CollectionViewSection<DetailSection, DetailItem>], animated: Bool) {
        methods.append(.updateWithNewData(data: data, animated: animated))
    }
}
