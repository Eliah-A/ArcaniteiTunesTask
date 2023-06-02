//
//  SceneDelegate.swift
//  Arcanite test task
//
//  Created by Илья Сергеевич on 01.06.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let searchViewController = SearchRouter.createModule()
        let navigationController = UINavigationController(rootViewController: searchViewController)

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

