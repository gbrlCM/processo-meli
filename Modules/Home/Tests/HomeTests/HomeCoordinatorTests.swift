//
//  HomeCoordinatorTests.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//
import RouterInterfaceTestHelpers
import RouterInterface
import UIKit
import Testing

@testable import Home

@MainActor
@Suite("GIVEN a HomeCoordinator")
struct HomeCoordinatorTests {
    let navigatorSpy: NavigatorSpy
    let routerSpy: RouterInterfaceSpy
    let sut: HomeCoordinator
    
    init() {
        navigatorSpy = NavigatorSpy()
        routerSpy = RouterInterfaceSpy()
        sut = HomeCoordinator(router: routerSpy)
        sut.navigator = navigatorSpy
    }
    
    @Test("WHEN goToSearch is called and router provide a view THEN it should push it")
    func testGoToSearchSuccess() async throws {
        routerSpy.viewResponse = UIViewController()
        sut.goToSearch(query: "query")
        #expect(navigatorSpy.methods == [.push])
    }
    
    @Test("WHEN gotToSearch is called and router does not provide a view THEN it should do nothing")
    func testGoToSearchFailed() async throws {
        sut.goToSearch(query: "query")
        #expect(navigatorSpy.methods.isEmpty)
    }
    
    @Test("WHEN presentErrorMessage is called THEN it should present it")
    func testPresentErrorMessage() async throws {
        sut.presentErrorMessage()
        #expect(navigatorSpy.methods == [.present])
    }
}
