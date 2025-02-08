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
    public let attributes: [Attributes]
    
    public struct Shipping: Codable, Equatable, Sendable {
        public let freeShipping: Bool
        
        public init(freeShipping: Bool) {
            self.freeShipping = freeShipping
        }
    }
    
    public struct Attributes: Codable, Equatable, Sendable {
        public let name: String
        public let valueName: String?
        
        public init(name: String, valueName: String) {
            self.name = name
            self.valueName = valueName
        }
    }
    
    public struct Installments: Codable, Equatable, Sendable {
        public let quantity: Int
        public let amount: Double
        public let rate: Double
        public let currencyId: String
        
        public init(quantity: Int, amount: Double, rate: Double, currencyId: String) {
            self.quantity = quantity
            self.amount = amount
            self.rate = rate
            self.currencyId = currencyId
        }
    }
    
    public init(
        id: String,
        title: String,
        condition: String,
        thumbnail: URL,
        currencyId: String,
        price: Double,
        originalPrice: Double?,
        availableQuantity: Int,
        officialStoreName: String?,
        acceptsMercadopago: Bool,
        shipping: Shipping,
        attributes: [Attributes]
    ) {
        self.id = id
        self.title = title
        self.condition = condition
        self.thumbnail = thumbnail
        self.currencyId = currencyId
        self.price = price
        self.originalPrice = originalPrice
        self.availableQuantity = availableQuantity
        self.officialStoreName = officialStoreName
        self.acceptsMercadopago = acceptsMercadopago
        self.shipping = shipping
        self.attributes = attributes
    }
}
