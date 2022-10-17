//
//  SceneDelegate.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(for: Self.self))
        let viewController: ViewController = storyBoard.instantiateViewController(
            identifier: "ViewController") { coder -> ViewController? in
                let viewModel = ViewModel()
                let viewController = ViewController(coder: coder, viewModel: viewModel)
                return viewController
            }
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

