//
//  DetailItem.swift
//  Detail
//
//  Created by Gabriel Ferreira de Carvalho on 09/02/25.
//
import Foundation
import UIKit

enum DetailItem: Hashable, Equatable, Sendable {
    case image(UIImage?)
    case generalInfo(GeneralInfoViewModel)
    case perk(PerkViewModel)
    case attribute(AttributeViewModel)
    
    struct GeneralInfoViewModel: Hashable, Equatable, Sendable {
        let name: String
        let price: String
    }
    
    struct AttributeViewModel: Hashable, Equatable, Sendable {
        let name: String
        let value: String
    }
    
    struct PerkViewModel: Hashable, Equatable, Sendable {
        let icon: UIImage?
        let value: String
    }
}
