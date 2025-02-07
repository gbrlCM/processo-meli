//
//  ImageRepository.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 07/02/25.
//

import Foundation
import UIKit

public protocol ImageRepositoryProtocol: Actor {
    func fetch(from url: URL) async -> UIImage?
}

public actor ImageRepository: ImageRepositoryProtocol {
    public static let shared: ImageRepositoryProtocol = ImageRepository(network: Network())
    
    private let cache: NSCache<NSURL, UIImage>
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.cache = NSCache()
        self.network = network
        cache.countLimit = 500
    }
    
    public func fetch(from url: URL) async -> UIImage? {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        let data = try? await network.fetch(from: url)
        
        guard let data, let image = UIImage(data: data) else { return nil }
        
        cache.setObject(image, forKey: url as NSURL)
        
        return image
    }
}
