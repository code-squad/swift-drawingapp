//
//  ChatServer.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/25.
//

import Foundation

struct Command: Decodable {
    let header: String
    let id: String
    let drawing: Drawing.DataType?
}

struct CommandResponse: Encodable {
    let header: String
    let id: String
    let drawing: [Drawing.DataType]?
}


enum Request {
    static let Login = "0x10"
    static let Chat = "0x20"
}

enum Response {
    static let Login = "0x11"
    static let Chat = "0x21"
}

struct Connection {
    
    var client: String
}

class ChatRequest: Operation {
    
    private let data: UserCommand
    
    private let client: String
    
    weak var server: ChatServer?
    
    init(data: UserCommand, client: String) {
        self.data = data
        self.client = client
    }
    
    override func main() {
        let command = Command(header: data.header, id: data.id, drawing: data.drawing)
        switch command.header {
        case Request.Login:
            let response = CommandResponse(header: Response.Login, id: command.id, drawing: nil)
            NotificationCenter.default.post(name: Notification.Name(client), object: nil, userInfo: ["response": response as Any])
            server?.database.query(key: client, value: command)
            server?.connections.append(Connection(client: client))
            
        case Request.Chat:
            let response = CommandResponse(header: Response.Chat, id: command.id, drawing: server?.database.query().compactMap { $0.drawing })
            NotificationCenter.default.post(name: Notification.Name(client), object: nil, userInfo: ["response": response as Any])
            for connection in server?.connections ?? [] {
                if connection.client == client { continue }
                NotificationCenter.default.post(name: Notification.Name(connection.client), object: nil, userInfo: ["response": response as Any])
            }
            
        default:
            return
        }
        
    }
}

class ChatServer {
    
    var connections: [Connection] = []
    
    var operationQueue: OperationQueue = OperationQueue.main
    
    var database: ChatDatabase = ChatDatabase()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(receive(_:)), name: .chatServer, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .chatServer, object: nil)
    }
    
    @objc
    func receive(_ notification: Notification) {
        guard let data = notification.userInfo?["data"] as? UserCommand,
        let client = notification.userInfo?["client"] as? String else { return }
        let request = ChatRequest(data: data, client: client)
        request.server = self
        operationQueue.addOperation(request)
    }
}

class ChatDatabase {
    
    private(set) var table: [String: Command] = [:]
    
    func query(key: String, value: Command) {
        table[key] = value
    }
    
    func query() -> [Command] {
        return table.map { $1 }
    }
}
