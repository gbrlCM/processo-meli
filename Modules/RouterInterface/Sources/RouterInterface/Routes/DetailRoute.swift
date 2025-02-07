//
//  DetailRoute.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//

import Model
import Foundation

public struct DetailRoute: Route {
    public static var path: String { "/detail" }
    
    public var path: String { Self.path }
    public let data: Data?
    
    public init(detail: ProductDetail) {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        self.data = try? encoder.encode(detail)
    }
}

extension DetailRoute: RouteDataDecoderProtocol {
    public typealias T = ProductDetail
}
