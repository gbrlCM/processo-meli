//
//  DetailPresenterSpy.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/25.
//

import DesignSystem
import Model
@testable import Detail

final class DetailPresenterSpy: DetailPresenterProtocol {
    enum Method: Equatable {
        case presentDetail(ProductDetail)
    }
    
    private(set) var methods: [Method] = []
    
    func presentDetail(_ detail: ProductDetail) async {
        methods.append(.presentDetail(detail))
    }
}
