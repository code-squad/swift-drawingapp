//
//  DrawingChatClient.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/23.
//

import Foundation
import os.log

fileprivate typealias Error = DrawingChatServiceError

class DrawingChatClient: DrawingChatServiceProviding {
    
    private let tcpManager = TCPManager(hostName: "localhost", port: 9090)
    
    lazy var shapeStream: AnyAsyncSequence<[ShapeData]> = tcpManager.messageStream
        .compactMap { data in
            let decoder = JSONDecoder()
            guard
                let shapesData = try? decoder.decode(Command.self, from: data),
                let data = shapesData.data
            else { return nil }
            let shapes = try decoder.decode([ShapeData].self, from: data)
            return shapes
        }
        .eraseToAnyAsyncSequence()
    
    func login() async throws {
        tcpManager.start()
        for await state in tcpManager.stateStream {
            if state == .ready { break }
        }
        logger.debug("세션 준비됨")
        
        let uuid = UUID().uuidString
        
        let command = Command(
            header: .login,
            id: uuid,
            length: nil,
            data: nil
        )
        
        var data: Data!
        try assertEncoding {
            data = try JSONEncoder().encode(command)
        }
        
        try await assertNetwork {
            try await tcpManager.send(data: data)
        }
        logger.debug("로그인 요청 시작됨, ID: \(uuid)")
        
        try await assertNetwork {
            for try await message in tcpManager.messageStream {
                if let command = try? JSONDecoder().decode(CommandResponse.self, from: message) {
                    logger.debug("로그인 응답 수신, ID: \(command.id)")
                    break
                }
            }
        }
    }
    
    func sendShapes(_ shapes: [any ShapeProtocol]) async throws {
        let encoder = JSONEncoder()
        var shapesData: Data!
        try assertEncoding {
            shapesData = try encoder.encode(shapes.map { $0.points })
        }
        
        let command = Command(
            header: .chat,
            id: UUID().uuidString,
            length: shapesData.count,
            data: shapesData
        )
        var commandData: Data!
        try assertEncoding {
            commandData = try encoder.encode(command)
        }
        try await assertNetwork {
            try await tcpManager.send(data: commandData)
        }
        logger.debug("\(shapes.map { $0.id }) 도형 전송됨")
    }
    
    private func assertNetwork(action: () async throws -> Void) async throws {
        do {
            try await action()
        } catch {
            logger.error("네트워크 오류: \(error.localizedDescription)")
            throw Error.network
        }
    }
    
    private func assertDecoding(action: () throws -> Void) throws {
        do {
            try action()
        } catch {
            logger.error("디코딩 오류: \(error.localizedDescription)")
            throw Error.decoding
        }
    }
    
    private func assertEncoding(action: () throws -> Void) throws {
        do {
            try action()
        } catch {
            logger.error("인코딩 오류: \(error.localizedDescription)")
            throw Error.encoding
        }
    }
    
}

fileprivate let logger = Logger(subsystem: "swift-drawingapp", category: "DrawingChatClient")
