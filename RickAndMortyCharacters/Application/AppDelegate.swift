//
//  AppDelegate.swift
//  RickAndMortyCharacters
//
//  Created by Mohamed Abdelhaseeb on 01/08/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator()
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
        coordinator?.start(animated: false)
        return true
    }
}

