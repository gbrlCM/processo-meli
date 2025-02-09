//
//  ListUpdateDelegate.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 05/02/25.
//

@MainActor
public protocol ListUpdateDelegate: AnyObject {
    associatedtype Section: Hashable & Sendable
    associatedtype Item: Hashable & Sendable
    
    func updateWithNewData(data: [CollectionViewSection<Section, Item>], animated: Bool)
    func loading(_ isLoading: Bool)
}
