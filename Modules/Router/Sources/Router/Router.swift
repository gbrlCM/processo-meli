import Detail
import Model
import Home
import Search
import RouterInterface
import Network
import UIKit

public final class Router: RouterProtocol {
    public init() {}
    
    public func view(for route: Route) -> UIViewController? {
        switch route.path {
        case DetailRoute.path:
            return buildDetailViewController(with: route)
        case SearchRoute.path:
            return buildSearchViewController(with: route)
        case HomeRoute.path:
            return buildHomeViewController()
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
    
    private func buildDetailViewController(with route: Route) -> UIViewController? {
        guard
            let data = route.data,
            let detail = DetailRoute.decode(data)
        else {
            return nil
        }
        
        return DetailFactory().build(detail)
    }
    
    private func buildHomeViewController() -> UIViewController? {
        guard let router = RouterProvider.shared.router else { return nil }
        return HomeFactory(router: router).build()
    }
}

