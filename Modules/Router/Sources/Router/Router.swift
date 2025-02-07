import Detail
import Model
import Home
import Search
import RouterInterface
import Network
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
            return HomeFactory().build()
        default:
            return nil
        }
    }
    
    private func buildSearchViewController(with route: Route) -> UIViewController? {
        guard
            let data = route.data,
            let query = SearchRoute.decode(data),
            let router = RouterProvider.shared.router
        else {
            return nil
        }
        
        return SearchFactory(router: router, network: Network()).build(query: query)
    }
}

