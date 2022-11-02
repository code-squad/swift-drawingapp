//
//  DrawingAppDriving.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/11/02.
//

import Foundation

protocol DrawingAppDriving {
    var canvasViewRepresenter: CanvasViewRepresentable { get }
    
    func createRandomRect()
    func selectShape(at: CGPoint)
    func drawPath(cgPointStream: AnyAsyncSequence<CGPoint>)
    func startSync()
}
