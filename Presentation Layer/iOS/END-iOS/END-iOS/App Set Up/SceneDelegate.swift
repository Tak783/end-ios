//
//  SceneDelegate.swift
//  END-iOS
//
//  Created by Tak Mazarura on 14/08/2024.
//

import CoreNetworking
import CorePresentation
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError("Window failed to initialise in SceneDelegate")
        }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SceneDelegate.accountsFeed()
        window?.makeKeyAndVisible()
    }
}

// MARK: - App View Factory App
extension SceneDelegate {
    private static func accountsFeed() -> UIViewController {
        let client = URLSessionHTTPClient()
        let router = Router(navigationController: .init())
        let coordinator = AppLaunchCoordinator(
            router: router,
            client: client
        )
        coordinator.start()
        return coordinator.router.navigationController
    }
}
