import Testing
@testable import Home

@MainActor
@Suite("GIVEN a HomeInteractor")
struct HomeInteractorTests {
    let coordinatorSpy: HomeCoordinatorSpy
    var sut: HomeInteractor
    
    init() {
        coordinatorSpy = HomeCoordinatorSpy()
        sut = HomeInteractor(coordinator: coordinatorSpy)
    }
    
    @Test("WHEN textValueDidChange is called THEN it should update the state")
    func testTestValueDidChange() async throws {
        #expect(sut.pageState.query == "")
        sut.textValueDidChange("query")
        #expect(sut.pageState.query == "query")
    }
    
    @Test("WHEN search is called with a empty query THEN it should call coordinator to present the error")
    func testSearchWithoutQuery() async throws {
        sut.search()
        #expect(coordinatorSpy.methods == [.presentErrorMessage])
    }
    
    @Test("WHEN search is called with a query THEN it should call coordinator to navigate to search")
    mutating func testSearchWithQuery() async throws {
        sut = HomeInteractor(coordinator: coordinatorSpy, state: .init(query: "query"))
        sut.search()
        #expect(coordinatorSpy.methods == [.goToSearch(query: "query")])
    }
}
