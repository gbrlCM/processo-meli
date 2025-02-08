//
//  RouterInterfaceSpy.swift
//  RouterInterface
//
//  Created by Gabriel Ferreira de Carvalho on 08/02/25.
//

import RouterInterface
import UIKit

public final class RouterInterfaceSpy: RouterProtocol {
    public func view(for route: any Route) -> UIViewController? {
        return UIViewController()
    }
    
    
}
