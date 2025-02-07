//
//  Route.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import Foundation

public protocol Route {
    var path: String { get }
    var data: Data? { get }
}
