//
//  ProductDetail.swift
//  Model
//
//  Created by Gabriel Ferreira de Carvalho on 06/02/25.
//
import Foundation

public struct ProductDetail: Codable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let condition: String
    public let thumbnail: URL
    public let currencyId: String
    public let price: Double
    public let originalPrice: Double?
    public let availableQuantity: Int
    public let officialStoreName: String?
    public let acceptsMercadopago: Bool
    public let shipping: Shipping
    
    public struct Shipping: Codable, Equatable, Sendable {
        public let freeShipping: Bool
    }
    
    public struct Attributes: Codable, Equatable, Sendable {
        let name: String
        let valueName: String
        let attributeGroupName: String
        let attributeGroupId: String
    }
    
    public struct Installments: Codable, Equatable, Sendable {
        let quantity: Int
        let amount: Double
        let rate: Double
        let currencyId: String
    }
}
