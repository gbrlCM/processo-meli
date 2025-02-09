//
//  CollectionViewSection.swift
//  DesignSystem
//
//  Created by Gabriel Ferreira de Carvalho on 09/02/25.
//

import Foundation

public struct CollectionViewSection<SectionType: Hashable, Item: Hashable>: Hashable, Equatable {
    public let sectionType: SectionType
    public let items: [Item]
    
    public init(sectionType: SectionType, items: [Item]) {
        self.sectionType = sectionType
        self.items = items
    }
}
