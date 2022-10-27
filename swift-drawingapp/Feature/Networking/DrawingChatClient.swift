//
//  DrawingChatClient.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/23.
//

import Foundation

typealias ShapeData = [Point]

class DrawingChatClient: DrawingChatServiceProviding {
    
    private let tcpManager = TCPManager(hostName: "localhost", port: 9090)
    
    lazy var shapeStream: AnyAsyncSequence<[Shape]> = tcpManager.messageStream
        .compactMap { data in
            let decoder = JSONDecoder()
            guard
                let shapesData = try? decoder.decode(Command.self, from: data),
                let data = shapesData.data
            else { return nil }
            let shapes = try decoder.decode([ShapeData].self, from: data)
            return shapes.map {
                let shape = ColoredShape(points: $0)
                shape.fillColor = .yellow
                shape.lineColor = .blue
                return shape
            }
        }
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
        
        for try await message in tcpManager.messageStream {
            let command = try JSONDecoder().decode(CommandResponse.self, from: message)
            break
        }
    }
    
    func sendShapes(_ shapes: [Shape]) async throws {
        let encoder = JSONEncoder()
        let shapesData = try encoder.encode(shapes.map { $0.points })
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
