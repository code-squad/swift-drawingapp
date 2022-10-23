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
    lazy var messageStream = AsyncThrowingStream<Data, Error> { continuation in
        addToMessageStream = { result in
            continuation.yield(with: result)
        }
    }
    
    private var addToMessageStream: ((Result<Data, Error>) -> Void)?
    
    // MARK: - State Stream
    lazy var stateStream = AsyncStream<NWConnection.State> { continuation in
        addToStateStream = { state in
            continuation.yield(state)
        }
    }
    
    private var addToStateStream: ((NWConnection.State) -> Void)?
    
    func start() {
        self.connection.stateUpdateHandler = { self.addToStateStream?($0) }
        self.receiveNextMessage()
        self.connection.start(queue: networkQueue)
    }
    
    func stop() {
        self.connection.cancel()
    }
    
    private func receiveNextMessage() {
        self.connection.receive(minimumIncompleteLength: 4, maximumLength: 1024) { content, context, isComplete, error in
            if let content {
                self.addToMessageStream?(.success(content))
            }
            if let error = error {
                self.addToMessageStream?(.failure(error))
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
