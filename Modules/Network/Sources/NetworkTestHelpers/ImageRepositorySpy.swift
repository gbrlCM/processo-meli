//
//  ImageRepositorySpy.swift
//  Network
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import Network
import UIKit
import Foundation

public final actor ImageRepositorySpy: ImageRepositoryProtocol {
    private var registeredImages: [URL: UIImage] = [:]
    
    public func fetch(from url: URL) async -> UIImage? {
        return registeredImages[url]
    }
    
    public func registerImage(key: URL, value: UIImage) async {
        registeredImages[key] = value
    }
}
