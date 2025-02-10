import Testing
import Foundation
import Model
@testable import Detail

@MainActor
@Test("GIVEN a DetailFactory WHEN build is called THEN it should return a DetailViewController")
func testFactoryBuild() async throws {
    let factory = DetailFactory()
    let result = factory.build(.mock())
    #expect(result is DetailViewController)
}
