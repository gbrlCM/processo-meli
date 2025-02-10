//
//  DetailInteractorTests.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/25.
//

import Testing
import Foundation
import Model
@testable import Detail

@MainActor
@Suite("GIVEN a DetailInteractor")
struct DetailInteractorTests {
    let sut: DetailInteractor
    let presenterSpy: DetailPresenterSpy
    
    init() {
        presenterSpy = DetailPresenterSpy()
        sut = DetailInteractor(presenter: presenterSpy, state: .init(detail: .mock()))
    }
    
    @Test("WHEN load detail is called THEN it should call presenter presentDetail")
    func testLoadDetail() async throws {
        await sut.loadDetail()
        #expect(presenterSpy.methods == [.presentDetail(.mock())])
    }
}
