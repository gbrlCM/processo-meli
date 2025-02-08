//
//  SearchFactoryTests.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//
import Testing
import RouterInterfaceTestHelpers
import NetworkTestHelpers
@testable import Search

@MainActor
@Test("GIVEN a SearchFactory WHEN build is called THEN it should return a SearchViewController")
func testFactory() async throws {
    let factory = SearchFactory(router: RouterInterfaceSpy(), network: NetworkSpy())
    let viewController = factory.build(query: "query")
    #expect(viewController is SearchViewController)
}
