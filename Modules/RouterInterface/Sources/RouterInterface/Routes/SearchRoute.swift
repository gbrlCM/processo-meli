//
//  SearchRoute.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//

import Foundation

public struct SearchRoute: Route {
    public static var path: String { "/search" }
    
    public var path: String { Self.path }
    public let data: Data?
    
    public init(query: String) {
        self.data = query.data(using: .utf8)
    }
}

extension SearchRoute: RouteDataDecoderProtocol {
    public static func decode(_ data: Data) -> String? {
        String(data: data, encoding: .utf8)
    }
}
