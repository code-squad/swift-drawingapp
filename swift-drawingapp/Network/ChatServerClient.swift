//
//  ChatServerClient.swift
//

import Foundation
import CoreGraphics

protocol ChatServerClientProtocol {
    var delegate: ChatServerDelegate? { get set }
    func login(id: String?)
    func sendData(shape: Shape)
}

protocol ChatServerDelegate: AnyObject {
    func loginSucceed()
    func dataReceived(shape: Shape)
}

class ChatServerClient: ChatServerClientProtocol {

    private var socket = DummySocket()
    weak var delegate: ChatServerDelegate?
    
    init() {
        socket.delegate = self
    }

    func sendData(shape: Shape) {
        // for문 돌려서 데이터 쏘기
    }
    
    func login(id: String?) {
//        guard let loginId = id,
//              let jsonString = Command(header: "0x10", id: loginId, data: nil).toJsonString() else {
//            return
//        }
        socket.login()
    }
}

extension ChatServerClient: DummyScoketDelegate {
    func pushData(data: Data?) {
        do {
            guard let data = data else { return }
            let command = try JSONDecoder().decode(Command.self, from: data)
            
            if let shapeData = command.data {
                if command.id == "line" {
                    let shape: Line = try decodeShape(from: shapeData)
                    delegate?.dataReceived(shape: shape)
                } else if command.id == "square" {
                    let shape: Square = try decodeShape(from: shapeData)
                    delegate?.dataReceived(shape: shape)
                }
            }
        } catch {
            
        }
    }
    
    func decodeShape<T : Decodable>(from data : Data) throws -> T
    {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
