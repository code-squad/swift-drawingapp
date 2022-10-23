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
    
    lazy var responseStream = AsyncStream<Data> { continuation in
        addToResponseStream = { data in
            continuation.yield(data)
        }
    }
    
    private var addToResponseStream: ((Data) -> Void)?
    
    func start() {
        print("will start")
        self.connection.stateUpdateHandler = self.didChange(state:)
        self.startReceive()
        self.connection.start(queue: networkQueue)
    }
    
    func stop() {
        self.connection.cancel()
        print("did stop")
    }
    
    private func didChange(state: NWConnection.State) {
        switch state {
        case .setup:
            break
        case .waiting(let error):
            print("is waiting: %@", "\(error)")
        case .preparing:
            break
        case .ready:
            break
        case .failed(let error):
            print("did fail, error: %@", "\(error)")
            self.stop()
        case .cancelled:
            print("was cancelled")
            self.stop()
        @unknown default:
            break
        }
    }
    
    private func startReceive() {
        self.connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { data, _, isDone, error in
            if let data = data, !data.isEmpty {
                print("did receive, data: %@", data as NSData)
                self.addToResponseStream?(data)
            }
            if let error = error {
                print("did receive, error: %@", "\(error)")
                self.stop()
                return
            }
            if isDone {
                print("did receive, EOF")
                self.stop()
                return
            }
            self.startReceive()
        }
    }
    
    func send(data: Data) {
        self.connection.send(content: data, completion: NWConnection.SendCompletion.contentProcessed { error in
            if let error = error {
                print("did send, error: %@", "\(error)")
                self.stop()
            } else {
                print("did send, data: %@", data as NSData)
            }
        })
    }
    
}
