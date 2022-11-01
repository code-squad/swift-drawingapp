//
//  ChatService.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/26.
//

import Combine
import Foundation
import Network

protocol ChatServiceProtocol {
    var dataPublisher: AnyPublisher<Data, Never> { get }
    func chat(message: Encodable)
}

final class ChatService: ChatServiceProtocol {
    var dataPublisher: AnyPublisher<Data, Never> { dataSubject.eraseToAnyPublisher() }

    private let connection: NWConnection
    private let dataSubject: PassthroughSubject<Data, Never>
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init() {
        dataSubject = .init()
        encoder = .init()
        decoder = .init()
        connection = NWConnection(host: .init("localhost"), port: .init("9090")!, using: .tcp)

        connect()
    }

    deinit {
        disconnect()
    }

    private func connect() {
        connection.start(queue: .global())
        login()
    }

    private func disconnect() {
        connection.cancel()
    }

    private func login() {
        let loginCommand = Command(header: "0x10", id: UUID().uuidString, length: nil, data: nil)

        let data = try! encoder.encode(loginCommand)
        connection.send(content: data, completion: .contentProcessed({ _ in }))
        connection.receive(minimumIncompleteLength: 4, maximumLength: 1024) { content, contentContext, isComplete, error in
            if error == nil {
                self.receve()
            }
        }
    }

    private func receve() {
        while true {
            Thread.sleep(forTimeInterval: 0.5)

            connection.receive(minimumIncompleteLength: 4, maximumLength: 1024) { [weak self] content, contentContext, isComplete, error in
                if let content = content,
                   let command = try? self?.decoder.decode(Command.self, from: content),
                   let data = command.data {
                    self?.dataSubject.send(data)
                }
            }
        }
    }

    func chat(message: Encodable) {
        let data = try! encoder.encode(message)
        let chatCommand = Command(header: "0x20", id: UUID().uuidString, length: data.count, data: data)
        let command = try! encoder.encode(chatCommand)
        connection.send(content: command, completion: .contentProcessed({ _ in }))
    }
}
