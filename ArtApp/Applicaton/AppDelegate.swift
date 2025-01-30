//
//  AppDelegate.swift
//  ArtApp
//
//  Created by Николай Игнатов on 28.01.2025.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var navigationController = UINavigationController()
    private lazy var coordinator = AppCoordinator(navigationController: navigationController)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coordinator.start()
        return true
    }
}

