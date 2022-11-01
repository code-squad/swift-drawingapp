//
//  DrawingChatService.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/26.
//

import Foundation

typealias ShapeData = [Point]

protocol DrawingChatServiceProviding {
    func login() async throws
    func sendShapes(_ shapes: [any ShapeProtocol]) async throws
    var shapeStream: AnyAsyncSequence<[ShapeData]> { get }
}

enum DrawingChatServiceError: Error {
    case network
    case decoding
    case encoding
}
