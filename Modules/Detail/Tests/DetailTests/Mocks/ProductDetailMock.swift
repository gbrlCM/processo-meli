//
//  ProductDetailMock.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/25.
//
import Model
import Foundation

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
