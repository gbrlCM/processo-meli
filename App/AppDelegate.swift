//
//  AppDelegate.swift
//  MeliProcess
//
//  Created by Gabriel Ferreira de Carvalho on 05/02/25.
//

import UIKit
import Router
import RouterInterface

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.overrideUserInterfaceStyle = .light
        let router = Router()
        RouterProvider.shared.router = router
        let viewController = router.view(for: HomeRoute()) ?? UIViewController()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

