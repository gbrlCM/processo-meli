//
//  SearchResponse.swift
//  Home
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//

import Foundation
import Model

struct SearchResponse: Decodable, Sendable, Equatable {
    let paging: Paging
    let results: [ProductDetail]
    
    struct Paging: Decodable, Sendable, Equatable {
        let total: Int
        let offset: Int
        let limit: Int
        
        var page: Int { offset + limit }
    }
}
