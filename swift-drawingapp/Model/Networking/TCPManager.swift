//
//  TCPManager.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/23.
//

import Network
import Foundation

class TCPManager {
    private let networkQueue = DispatchQueue(label: "chatQueue")
    
    let connection: NWConnection
    
    init(hostName: String, port: Int) {
        let host = NWEndpoint.Host(hostName)
        let port = NWEndpoint.Port("\(port)")!
        self.connection = NWConnection(host: host, port: port, using: .tcp)
    }
    
    // MARK: - Message Stream
    private(set) lazy var messageStream = AsyncThrowingStream<Data, Error> {
        messageContinuation = $0
    }
    
    private var messageContinuation: AsyncThrowingStream<Data, Error>.Continuation?
    
    // MARK: - State Stream
    private(set) lazy var stateStream = AsyncStream<NWConnection.State> {
        stateContinuation = $0
    }
    
    private var stateContinuation: AsyncStream<NWConnection.State>.Continuation?
    
    func start() {
        self.connection.stateUpdateHandler = { state in
            self.stateContinuation?.yield(state)
        }
        self.receiveNextMessage()
        self.connection.start(queue: networkQueue)
    }
    
    func stop() {
        self.connection.cancel()
    }
    
    private func receiveNextMessage() {
        self.connection.receive(minimumIncompleteLength: 4, maximumLength: 25000) { content, context, isComplete, error in
            if let content {
                self.messageContinuation?.yield(content)
            }
            if let error = error {
                self.messageContinuation?.finish(throwing: error)
                self.stop()
                return
            }
            self.receiveNextMessage()
        }
    }
    
    func send(data: Data) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            self.connection.send(content: data, completion: NWConnection.SendCompletion.contentProcessed { error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume(returning: ())
            })
        }
    }
    
}
