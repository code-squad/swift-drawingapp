//
//  ChatServerClient.swift
//

import Foundation
import Starscream


class ChatServerClient: WebSocketDelegate {
    
    init() {}
    
    private var socket: WebSocket?
    private var id: String?
    
    func connect(id: String?) {
        self.id = id
        let url = URL(string: "http://127.0.0.1:8080/chatserver")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
            login(id: self.id)
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let text):
            print("received text: \(text)")
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            print("websocket is canclled")
        case .error(let error):
            print("websocket is error = \(error!)")
        }
    }
    
    func login(id: String?) {
        guard let loginId = id,
              let jsonString = Command(header: "0x10", id: loginId).toJsonString() else {
            return
        }
        socket?.write(string: jsonString) {
            print("login success")
        }
    }
}

struct Command : Encodable {
    let header : String
    let id : String
    
    func toJsonString() -> String? {
        if let jsonData = try? JSONEncoder().encode(self) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }
        return nil
    }
}

