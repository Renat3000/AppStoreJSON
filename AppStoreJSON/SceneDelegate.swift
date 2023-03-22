//
//  SceneDelegate.swift
//  AppStoreJSON
//
//  Created by Renat Nazyrov on 21.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let navController = BaseTabBarController()
            window.rootViewController = navController
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }
    
}
