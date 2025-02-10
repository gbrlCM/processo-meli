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
    
    static func == (lhs: DetailItem, rhs: DetailItem) -> Bool {
        switch (lhs, rhs) {
        case (.image(let lhsImage), .image(let rhsImage)):
            return lhsImage?.pngData() == rhsImage?.pngData()
        case (.generalInfo(let lhsInfo), .generalInfo(let rhsInfo)):
            return lhsInfo == rhsInfo
        case (.perk(let lhsPerk), .perk(let rhsPerk)):
            return lhsPerk.value == rhsPerk.value && lhsPerk.icon?.pngData() == rhsPerk.icon?.pngData()
        case (.attribute(let lhsAttribute), .attribute(let rhsAttribute)):
            return lhsAttribute == rhsAttribute
        default:
            return false
        }
    }
}
