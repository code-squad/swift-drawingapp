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
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .white
        let viewController = UIStoryboard(name: "CanvasViewController", bundle: .main).instantiateViewController(identifier: "CanvasViewController") { coder in
            let viewModel = CanvasViewModel(
                polygonDrawingUseCase: PolygonDrawingUseCaseImpl(),
                inkDrawingUseCase: InkDrawingUseCaseImpl(),
                toolSelectionUseCase: ToolSelectionUseCaseImpl(),
                itemSelectionUseCase: ItemSelectionUseCaseImpl()
            )
            return CanvasViewController(coder: coder, viewModel: viewModel)
        }
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

