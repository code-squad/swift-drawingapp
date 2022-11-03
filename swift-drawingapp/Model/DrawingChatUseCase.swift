//
//  DrawingChatUseCase.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/26.
//

import Foundation

typealias ShapeData = [Point]

protocol LoginUseCase {
    func login() async throws
}

protocol SendShapeUseCase {
    func sendShapes(_ shapes: [any ShapeProtocol]) async throws
}

protocol ReceiveShapeUseCase {
    var shapeStream: AnyAsyncSequence<[ShapeData]> { get }
}

enum DrawingChatServiceError: Error {
    case network
    case decoding
    case encoding
}
