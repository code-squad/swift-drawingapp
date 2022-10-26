//
//  ChatService.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/26.
//

import Foundation
import Network

protocol ChatServiceProtocol {
    func connect()
    func disconnect()
}

final class ChatService: ChatServiceProtocol {
    let connection: NWConnection

    init() {
        connection = NWConnection(host: .init("localhost"), port: .init("9090")!, using: .tcp)
    }

    func connect() {
        connection.start(queue: .global())
    }

    func disconnect() {
        connection.cancel()
    }

    func login() {
        let loginCommand = Command(header: "0x10", id: UUID().uuidString, length: nil, data: nil)

        let data = try! JSONEncoder().encode(loginCommand)
        connection.send(content: data, completion: .contentProcessed({ error in
            print("sended \(data) \(error)")
        }))
        connection.receive(minimumIncompleteLength: 4, maximumLength: 1024) { content, contentContext, isComplete, error in
            let response = try! JSONDecoder().decode(CommandResponse.self, from: content!)
            print("response \(response) \(error)")
        }
    }
}
