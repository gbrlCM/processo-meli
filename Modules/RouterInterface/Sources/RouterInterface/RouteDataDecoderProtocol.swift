//
//  RouteDataDecoderProtocol.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//

import Foundation

public protocol RouteDataDecoderProtocol {
    associatedtype T
    static func decode(_ data: Data) -> T?
}

extension RouteDataDecoderProtocol where T: Decodable {
    public static func decode(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try? decoder.decode(T.self, from: data)
    }
}
