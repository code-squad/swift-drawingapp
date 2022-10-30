//
//  SceneDelegate.swift
//  swift-drawingapp
//
//  Created by JK on 2022/07/04.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var server: ChatServer?
    
    var chatRepository: ChatRepository?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.backgroundColor = .white
        
        // ChatServer 생성 (Mock)
        server = ChatServer()
        
        // CanvasViewModel 생성
        let viewModel = CanvasViewModel()
        
        // ChatRepository 생성
        chatRepository = ChatRepository(
            polygonDrawingUseCase: viewModel,
            inkDrawingUseCase: viewModel,
            syncUseCase: viewModel
        )
        
        // CanvasViewController 생성
        let viewController = UIStoryboard(name: "CanvasViewController", bundle: .main)
            .instantiateViewController(identifier: "CanvasViewController") { coder in
            
            return CanvasViewController(
                coder: coder,
                polygonDrawingUseCase: viewModel,
                inkDrawingUseCase: viewModel,
                toolSelectionUseCase: viewModel,
                itemSelectionUseCase: viewModel,
                drawingOrSelectionUseCase: viewModel,
                syncUseCase: viewModel
            )
        }
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
