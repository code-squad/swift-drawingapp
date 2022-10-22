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

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let drawingLayerMaker = DrawingLayerMaker()
        let drawingVM = createDrawingViewModel()
        
        let drawingVC = DrawingViewController(
            drawingLayerMaker: drawingLayerMaker,
            viewModel: drawingVM
        )
        window.rootViewController = drawingVC
        window.makeKeyAndVisible()
    }
    
    func createDrawingViewModel() -> DrawingViewModelProtocol {
        let squareFactory = SquareFactory()
        let lineFactory = LineFactory()
        let drawingFactory = DrawingFactory(
            squareFactory: squareFactory,
            lineFactory: lineFactory
        )
        
        let drawingStore = DrawingStore()
        
        let drawingVM = DrawingViewModel(
            drawingStore: drawingStore,
            drawingFactory: drawingFactory
        )
        return drawingVM
    }
    
}

