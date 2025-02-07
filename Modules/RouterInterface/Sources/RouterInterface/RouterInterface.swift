
import UIKit

@MainActor
public protocol RouterInterface {
    func view(for route: Route) -> UIViewController?
}
