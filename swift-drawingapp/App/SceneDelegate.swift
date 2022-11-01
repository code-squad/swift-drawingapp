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
        
        let appDriver = DrawingAppDriver()
        
        let drawingAppVC = DrawingAppViewController()
        drawingAppVC.setAppDriver(appDriver)
        
        window?.rootViewController = drawingAppVC
        window?.makeKeyAndVisible()
    }
    
}
