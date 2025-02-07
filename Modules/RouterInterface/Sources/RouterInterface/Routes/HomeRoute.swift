//
//  HomeRoute.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//

import Model
import Foundation

public struct HomeRoute: Route {
    public static var path: String { "/home" }
    
    public var path: String { Self.path }
    public let data: Data? = nil
    
    public init() {}
}
