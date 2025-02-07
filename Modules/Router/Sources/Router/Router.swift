// The Swift Programming Language
// https://docs.swift.org/swift-book
import Detail
import Model
import Home
import Search
import RouterInterface
import UIKit

public final class Router: RouterInterface {
    public init() {}
    
    public func view(for route: Route) -> UIViewController? {
        switch route.path {
        case DetailRoute.path:
            return UIViewController()
        case SearchRoute.path:
            return buildSearchViewController(with: route)
        case HomeRoute.path:
            return UIViewController()
        default:
            return nil
        }
    }
    
    private func buildSearchViewController(with route: Route) -> UIViewController? {
        guard
            let data = route.data,
            let query = SearchRoute.decode(data)
        else {
            return nil
        }
        
        return SearchFactory().build()
    }
}

