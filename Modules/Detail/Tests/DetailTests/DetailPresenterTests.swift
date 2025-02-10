//
//  DetailPresenterTests.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/25.
//

import Testing
import Foundation
import Model
import UIKit
import DesignSystem
import NetworkTestHelpers
@testable import Detail

@MainActor
@Suite("GIVEN a DetailPresenter")
struct DetailPresenterTests {
    let sut: DetailPresenter
    let viewControllerSpy: DetailViewControllerSpy
    let imageProviderSpy: ImageRepositorySpy
    let detail: ProductDetail
    
    init() throws {
        viewControllerSpy = DetailViewControllerSpy()
        imageProviderSpy = ImageRepositorySpy()
        sut = DetailPresenter(imageProvider: imageProviderSpy)
        detail = .mock(
            title: "Title",
            thumbnail: try #require(URL(string: "https://www.example.com.br/product")),
            thumbnailId: "product",
            currencyId: "BRL",
            price: 1000,
            acceptsMercadopago: true,
            shipping: .init(freeShipping: true),
            attributes: [
                .init(name: "name", valueName: "value"),
                .init(name: "name", valueName: nil)
            ]
        )
        sut.viewController = viewControllerSpy
    }
    
    @Test(
        "WHEN present detail is called THEN it should call viewController with the screen layout"
    )
    func testPresentDetail() async throws {
        let url = try #require(ImageUrlBuilder.build(for: "product"))
        let image = try #require(UIImage(systemName: "checkmark"))
        await imageProviderSpy.registerImage(key: url, value: image)
        await sut.presentDetail(detail)
        
        let expectedResult: [CollectionViewSection<DetailSection, DetailItem>] = [
            .init(sectionType: .presentation, items: [.image(image)]),
            .init(
                sectionType: .list,
                items: [
                    .generalInfo(.init(name: "Title", price: "R$ 1.000,00")),
                    .perk(.init(icon: UIImage(systemName: "shippingbox.fill"), value: "Frete Gratis!")),
                    .perk(.init(icon: UIImage(systemName: "creditcard.fill"), value: "Pagamento com Mercado Pago")),
                ]
            ),
            .init(sectionType: .attributes, items: [.attribute(.init(name: "name", value: "value"))])
        ]
        #expect(
            viewControllerSpy.methods == [
                .loading(true),
                .updateWithNewData(data: expectedResult, animated: true),
                .loading(false)
            ]
        )
        
        await #expect(imageProviderSpy.methods == [.fetch(from: url)])
    }
    
    @Test(
        "WHEN present detail is called but cannot fetch the ideal thumbnail THEN it should call viewController with the screen layout with the low quality version"
    )
    func testPresentDetailWithLowQualityVersion() async throws {
        let highQualityUrl = try #require(ImageUrlBuilder.build(for: "product"))
        let url = detail.thumbnail
        let image = try #require(UIImage(systemName: "checkmark"))
        await imageProviderSpy.registerImage(key: url, value: image)
        await sut.presentDetail(detail)
        
        let expectedResult: [CollectionViewSection<DetailSection, DetailItem>] = [
            .init(sectionType: .presentation, items: [.image(image)]),
            .init(
                sectionType: .list,
                items: [
                    .generalInfo(.init(name: "Title", price: "R$ 1.000,00")),
                    .perk(.init(icon: UIImage(systemName: "shippingbox.fill"), value: "Frete Gratis!")),
                    .perk(.init(icon: UIImage(systemName: "creditcard.fill"), value: "Pagamento com Mercado Pago")),
                ]
            ),
            .init(sectionType: .attributes, items: [.attribute(.init(name: "name", value: "value"))])
        ]
        #expect(
            viewControllerSpy.methods == [
                .loading(true),
                .updateWithNewData(data: expectedResult, animated: true),
                .loading(false)
            ]
        )
        await #expect(imageProviderSpy.methods == [.fetch(from: highQualityUrl), .fetch(from: url)])
    }
}
