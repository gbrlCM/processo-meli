//
//  Layoutable.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

@MainActor
public protocol Layoutable {
    func setupHierarchy()
    func setupLayout()
    func setupStyle()
}

extension Layoutable {
    public func setupHierarchy() {}
    public func setupLayout() {}
    public func setupStyle() {}
    public func setupView() {
        setupHierarchy()
        setupLayout()
        setupStyle()
    }
}

