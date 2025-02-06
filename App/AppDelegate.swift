//
//  AppDelegate.swift
//  MeliProcess
//
//  Created by Gabriel Ferreira de Carvalho on 05/02/25.
//

import UIKit
import Home

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        //        window.rootViewController = UINavigationController(rootViewController: NoteViewController(palette: .classic, repository: NotesRepository()))
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

