//
//  ChatClient.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation
import Network

final class ChatClient {
    static let local: ChatClient? = .init(hostName: "localhost", with: 9090)

    var fetchedData: ((Command) -> Void)?

    private let networkQueue = DispatchQueue(label: "network_queue")
    private var listener : NWListener
    private var connection: NWConnection
    private var threads = [Thread]()

    private init?(hostName: String, with port: NWEndpoint.Port) {
        let options = NWProtocolTCP.Options()
        let params = NWParameters.init(tls: .none, tcp: options)
        params.allowLocalEndpointReuse = true
        let binding = try? NWListener(using: params, on: port)
        guard binding != nil else { return nil }
        listener = binding!
        connection = NWConnection(host: NWEndpoint.Host(hostName), port: port, using: params)
    }

    func connect() async -> Bool {
        setupListener()
        print("Chat Client is running...")
        return await withCheckedContinuation { continuation in
            let command = Command(header: Request.Login, id: UUID().uuidString, length: nil, data: nil)
            let data = try? JSONEncoder().encode(command)
            connection.send(content: data, completion: NWConnection.SendCompletion.contentProcessed { error in
                if error != nil {
                    continuation.resume(returning: false)
                } else {
                    continuation.resume(returning: true)
                }
            })
        }
    }

    func send(data: Data) {
        connection.send(content: data, completion: NWConnection.SendCompletion.contentProcessed { [weak self] error in
            guard let self else { return }
            if let error {
                print("\(self.connection) error - ", error.localizedDescription)
            }
        })
    }

    private func setupListener() {
        listener.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("Listener ready on \(String(describing: self.listener.port))")
            case .failed(let error):
                print("Listener failed with \(error), restarting")
                self.listener.cancel()
            default:
                break
            }
        }
        listener.newConnectionHandler = setup(connection:)
        listener.start(queue: networkQueue)
    }

    private func setup(connection: NWConnection) {
        connection.stateUpdateHandler = { [weak self] newState in
            switch newState {
            case .ready:
                print("ready.. \(connection)")
                self?.setupReceiverFromClient(of: connection)
            case .failed(_):
                connection.cancel()
                print("\(connection) failed")
            case .cancelled:
                print("\(connection) cancelled")
            default:
                print("\(connection) others")
                break
            }
        }
        connection.start(queue: self.networkQueue)
    }

    private func receive(from connection : NWConnection) {
        connection.receive(minimumIncompleteLength: 4, maximumLength: 1024) { [weak self] (content, context, isComplete, error) in
            if let data = content, !data.isEmpty {
                guard let command = try? JSONDecoder().decode(Command.self, from: data) else {
                    print("\(connection) unknown command")
                    connection.cancel()
                    return
                }
                self?.fetchedData?(command)
            }
            if let error = error {
                print("\(connection) error - ", error.localizedDescription)
            }
        }
    }

    private func setupReceiverFromClient(of connection: NWConnection) {
        let thread = Thread {
            while connection.state == .ready {
                Thread.sleep(forTimeInterval: 0.5)
                self.networkQueue.async {
                    self.receive(from: connection)
                }
            }
        }
        thread.start()
        threads.append(thread)
    }

    deinit {
        connection.cancel()
    }
}
