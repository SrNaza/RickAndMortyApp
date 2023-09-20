//
//  AppDelegate.swift
//  MortyApp
//
//  Created by Nazareth Villalba on 19/09/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Setup
        setupView()
        
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                UINavigationBar.appearance().barTintColor = .black
            } else {
                UINavigationBar.appearance().barTintColor = .white
            }
        } else {
            UINavigationBar.appearance().barTintColor = .white
        }
        
        return true
    }

    // MARK: - Private methods
    private func setupView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        let nav = CustomNavigationControllers(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
