//
//  SearchCoordinatorTests.swift
//  Search
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import Testing
import RouterInterface
import RouterInterfaceTestHelpers
import UIKit
@testable import Search

@MainActor
@Suite("GIVEN a SearchCoordinator")
struct SearchCoordinatorTests {
    let routerSpy: RouterInterfaceSpy
    let navigator: NavigatorSpy
    let sut: SearchCoordinator
    
    init() {
        routerSpy = RouterInterfaceSpy()
        navigator = NavigatorSpy()
        sut = SearchCoordinator(router: routerSpy)
        sut.navigator = navigator
    }
    
    @Test("WHEN go to detail is called and router return a view THEN it should push the view")
    func testGoToDetailSuccess() async throws {
        routerSpy.viewResponse = UIViewController()
        
        sut.goToDetail(.mock())
        
        #expect(navigator.methods == [.push])
        #expect(routerSpy.methods == [.view] && routerSpy.lastCalledRoute?.path == DetailRoute.path)
    }
    
    @Test("WHEN goToDetail is called and router do not return a view THEN it should do nothing")
    func testGoToDetailFail() async throws {
        sut.goToDetail(.mock())
        
        #expect(navigator.methods.isEmpty)
        #expect(routerSpy.methods == [.view] && routerSpy.lastCalledRoute?.path == DetailRoute.path)
    }
    
    @Test("WHEN presentSearchError is called THEN it should present the alert")
    func testPresentSearchError() async throws {
        sut.presentSearchError()
        
        #expect(navigator.methods == [.present])
    }
}
