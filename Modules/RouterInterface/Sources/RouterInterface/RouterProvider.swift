//
//  RouterProvider.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//

@MainActor
public final class RouterProvider {
    public static var shared: RouterProvider = .init()
    
    private init() {}
    
    public var router: RouterInterface? = nil
}
