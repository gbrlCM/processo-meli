//
//  ListUpdateDelegate.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 05/02/25.
//

public protocol ListUpdateDelegate: AnyObject {
    associatedtype Section: Hashable & Sendable
    associatedtype Item: Hashable & Sendable
    
    @MainActor
    func updateWithNewData(data: [Section: [Item]], animated: Bool)
}
