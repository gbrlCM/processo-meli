//
//  SearchResponseMock.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

@testable import Search
import Model
import Foundation

extension SearchResponse {
    static var mock: SearchResponse {
        SearchResponse(
            paging: .init(total: 100, offset: 0, limit: 10),
            results: [
                ProductDetail(
                    id: "",
                    title: "",
                    condition: "",
                    thumbnail: URL(fileURLWithPath: ""),
                    currencyId: "",
                    price: 0,
                    originalPrice: nil,
                    availableQuantity: 1,
                    officialStoreName: nil,
                    acceptsMercadopago: true,
                    shipping: .init(freeShipping: true),
                    attributes: []
                )
            ]
        )
    }
}
