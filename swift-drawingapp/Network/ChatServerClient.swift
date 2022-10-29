//
//  ChatServerClient.swift
//

import Foundation
import CoreGraphics

protocol ChatServerClientProtocol {
    var delegate: ChatServerDelegate? { get set }
    func login(id: String)
    func sendData(shape: Shape)
}

protocol ChatServerDelegate: AnyObject {
    func loginSucceed()
    func dataReceived(shape: Shape)
}

class ChatServerClient: ChatServerClientProtocol {
    
    private var socket: SocketManagerProtocol
    weak var delegate: ChatServerDelegate?
    var userId: String?
    
    init(socket: SocketManagerProtocol) {
        self.socket = socket
        self.socket.delegate = self
    }

    func sendData(shape: Shape) {
        guard let commandData = convertToCommand(shape: shape) else {
            return
        }
        socket.sendData(data: commandData)
    }
    
    func login(id: String) {
        guard let jsonData = Command(header: ChatRequestTyoe.login.rawValue, id: id, length: nil, data: nil, shapeType: nil).toJsonData() else {
            return
        }
        self.userId = id
        socket.connect()
        socket.sendData(data: jsonData)
    }
    
    func convertToCommand(shape: Shape) -> Data? {
        if let square = shape as? Square {
            let squareData = square.toJsonData()
            return Command(header: ChatRequestTyoe.chat.rawValue, id: userId!, length: squareData?.count, data: squareData, shapeType: "square").toJsonData()
        }
        
        if let line = shape as? Line {
            let lineData = line.toJsonData()
            return Command(header: ChatRequestTyoe.chat.rawValue, id: userId!, length: lineData?.count, data: lineData, shapeType: "line").toJsonData()
        }
        
        return nil
    }
}

extension ChatServerClient: SocketManagerDelegate {
    func dataReceived(data: Data) {
        guard let command = try? JSONDecoder().decode(Command.self, from: data) else {
            print("Wrong Command Format")
            return
        }
        guard let reponseType = ChatResponseType(rawValue: command.header) else {
            print("Undefined response")
            return
        }
        
        switch reponseType {
        case .loginSucceed:
            if command.id == userId {
                delegate?.loginSucceed()
            }
        case .shapePushed:
            guard let shape = try? convertToShape(command: command) else {
                print("Decoding Error")
                return
            }
            delegate?.dataReceived(shape: shape)
        }
    }
    
    func convertToShape(command: Command) throws -> Shape? {
        guard let shapeData = command.data else {
            throw ChatClientError.commandDataIsNil
        }
        
        if command.shapeType == "line" {
            guard let line = try? JSONDecoder().decode(Line.self, from: shapeData) else {
                throw ChatClientError.failToDecodeLineData
            }
            return line
        } else if command.shapeType == "square" {
            guard let square = try? JSONDecoder().decode(Square.self, from: shapeData) else {
                throw ChatClientError.failToDecodeSquareData
            }
            return square
        }
        return nil
    }
}

enum ChatClientError: Error {
    case commandDataIsNil
    case failToDecodeLineData
    case failToDecodeSquareData
}
