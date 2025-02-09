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
    static func mock(
        paging: SearchResponse.Paging = .init(total: 100, offset: 0, limit: 10),
        results: [ProductDetail] = [.mock()]
    ) -> SearchResponse {
        SearchResponse(
            paging: paging,
            results: results
        )
    }
}

extension ProductDetail {
    static func mock(
        id: String = "",
        title: String = "",
        condition: String = "",
        thumbnail: URL = URL(fileURLWithPath: ""),
        thumbnailId: String = "",
        currencyId: String = "",
        price: Double = 0,
        originalPrice: Double? = nil,
        availableQuantity: Int =  1,
        officialStoreName: String? = nil,
        acceptsMercadopago: Bool = true,
        shipping: Shipping = .init(freeShipping: true),
        attributes: [Attributes] = []
    ) -> ProductDetail {
        ProductDetail(
            id: id,
            title: title,
            condition: condition,
            thumbnail: thumbnail,
            thumbnailId: thumbnailId,
            currencyId: currencyId,
            price: price,
            originalPrice: originalPrice,
            availableQuantity: availableQuantity,
            officialStoreName: officialStoreName,
            acceptsMercadopago: acceptsMercadopago,
            shipping: shipping,
            attributes: attributes
        )
    }
}
