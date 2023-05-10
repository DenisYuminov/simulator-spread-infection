//
//  SceneDelegate.swift
//  technotest
//
//  Created by macbook Denis on 5/8/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let appCoordinator = AppCoordinator(appPresentationAssembly: AppPresentationAssembly())
        window.rootViewController = appCoordinator.createRootViewController()
        window.makeKeyAndVisible()
    }
}

