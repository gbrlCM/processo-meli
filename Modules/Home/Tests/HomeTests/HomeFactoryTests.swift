//
//  HomeFactoryTests.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import Testing
import RouterInterfaceTestHelpers
@testable import Home

@MainActor
@Test("GIVEN a HomeFactory WHEN build is called THEN it should return a HomeViewController")
func testFactory() async throws {
    let factory = HomeFactory(router: RouterInterfaceSpy())
    let result = factory.build()
    
    #expect(result is HomeViewController)
}
