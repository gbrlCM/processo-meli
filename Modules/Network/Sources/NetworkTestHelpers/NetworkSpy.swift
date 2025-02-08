//
//  NetworkSpy.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//
import Network
import Foundation

public actor NetworkSpy: NetworkProtocol {
    public enum Method: Equatable, Sendable {
        case fetch(request: URLRequest)
        case fetch(url: URL)
        case fetchData(url: URL)
    }
    
    private var registredResponses: [URL: Any] = [:]
    public private(set) var methods: [Method] = []
    
    public init() {}
    
    public func fetch<T>(from request: URLRequest) async throws -> (T, URLResponse) where T : Decodable {
        methods.append(.fetch(request: request))
        guard let url = request.url else { throw URLError(.badURL) }
        let value: T = try fetchResponse(from: url)
        return (value, URLResponse())
    }
    
    public func fetch<T>(from url: URL) async throws -> (T, URLResponse) where T : Decodable {
        methods.append(.fetch(url: url))
        let value: T = try fetchResponse(from: url)
        return (value, URLResponse())
    }
    
    public func fetch(from url: URL) async throws -> Data {
        methods.append(.fetchData(url: url))
        return try fetchResponse(from: url)
    }
    
    private func fetchResponse<T>(from url: URL) throws -> T {
        if let value = registredResponses[url] as? T {
            return value
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
    public func registerResponse(key: URL, _ value: Any) async {
        registredResponses[key] = value
    }
}
