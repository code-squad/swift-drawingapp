//
//  NetworkController.swift
//  swift-drawingapp
//
//  Created by Sunghyun Kim on 2022/10/23.
//

import Foundation

class NetworkController {
    private let tcpManager = TCPManager(hostName: "localhost", port: 9090)
    
    enum Error: Swift.Error {
        case login
        case receive
        case send
    }
    
    func login() throws {
        let uuid = UUID().uuidString
        
        let command = Command(
            header: .login,
            id: uuid,
            length: nil,
            data: nil
        )
        let data = try JSONEncoder().encode(command)
        
        tcpManager.start()
        tcpManager.send(data: data)
    }
    
    private func sendShapes(_ shapes: [Shape]) {
        
    }
    
    
    
}
