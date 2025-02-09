//
//  ImageUrlBuilder.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 09/02/25.
//
import Foundation

enum ImageUrlBuilder {
    static func build(for id: String) -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "http2.mlstatic.com"
        components.path = "/D_NQ_NP_\(id)-O.jpg"
        return components.url
    }
}
