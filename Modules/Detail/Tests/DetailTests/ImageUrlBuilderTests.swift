//
//  ImageUrlBuilderTests.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 10/02/25.
//

import Testing
@testable import Detail

@Test("GIVEN a ImageUrlBuilder WHEN build is called THEN it should produce a valid URL")
func testUrlBuilder() async throws {
    let url = try #require(ImageUrlBuilder.build(for: "product"))
    #expect(url.absoluteString == "http://http2.mlstatic.com/D_NQ_NP_product-O.jpg")
}
