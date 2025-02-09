//
//  SearchPresenterTests.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import Testing
import Model
import Foundation
import DesignSystem
@testable import Search

@Suite("GIVEN a SearchPresenter")
@MainActor
struct SearchPresenterTests {
    var sut: SearchPresenter
    var viewController: SearchViewControllerSpy
    
    init() {
        sut = SearchPresenter()
        viewController = SearchViewControllerSpy()
        sut.viewController = viewController
    }
    
    @Test("WHEN loading is called THEN it should call viewController loading function")
    func testLoading() async throws {
        sut.loading(isLoading: true)
        #expect(viewController.methods == [.loading(true)])
    }
    
    @Test("WHEN updateData is called THEN it should transform correctly the detail into a cell viewModel")
    func testUpdateData() async throws {
        let url = try #require(URL(string: "https://www.example.com.br"), "URL should be valid")
        
        let input: [ProductDetail] = [.mock(id: "id", title: "title", thumbnail: url, currencyId: "BRL", price: 199.99)]
        sut.updateData(input, animated: true)
        let output = viewController.methods.first
        
        #expect(
            output == .updateWithNewData(
                data: [
                    CollectionViewSection(
                        sectionType: 0,
                        items: [ProductCellViewModel(name: "title", price: "R$ 199,99", thumbnail: url, id: "id")]
                    )
                ],
                animated: true
            )
        )
    }
}
