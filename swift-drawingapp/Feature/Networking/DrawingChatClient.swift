//
//  DrawingChatClient.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/23.
//

import Foundation

typealias ShapeData = [Point]

class DrawingChatClient {
    private let tcpManager = TCPManager(hostName: "localhost", port: 9090)
    
    lazy var shapesStream: AnyAsyncSequence<[ShapeData]> = tcpManager.messageStream
        .map { try JSONDecoder().decode([ShapeData].self, from: $0) }
        .eraseToAnyAsyncSequence()
    
    func login() async throws {
        tcpManager.start()
        for await state in tcpManager.stateStream {
            if state == .ready { break }
        }
        
        let uuid = UUID().uuidString
        
        let command = Command(
            header: .login,
            id: uuid,
            length: nil,
            data: nil
        )
        let data = try JSONEncoder().encode(command)
        try await tcpManager.send(data: data)
    }
    
    func sendShapes(_ shapes: [ShapeData]) async throws {
        let encoder = JSONEncoder()
        let shapesData = try encoder.encode(shapes)
        let command = Command(
            header: .chat,
            id: UUID().uuidString,
            length: shapesData.count,
            data: shapesData
        )
        let commandData = try encoder.encode(command)
        try await tcpManager.send(data: commandData)
    }
    
}
