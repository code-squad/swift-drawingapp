//
//  SocketModelConverter.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/29.
//

import Foundation

enum ChatCommandError: Error {
    case commandDataIsNil
    case failToDecodeLineData
    case failToDecodeSquareData
    case failToEncodeCommand
}

class ChatCommandConverter {
    func dataToCommand(data: Data) -> Command? {
        guard let command = try? JSONDecoder().decode(Command.self, from: data) else {
            return nil
        }
        return command
    }
        
    func convertToCommand(shape: Shape, userId: String?) -> Command? {
        if let square = shape as? Square {
            let squareData = square.toJsonData()
            return Command(header: ChatRequestTyoe.chat.rawValue, id: userId!, length: squareData?.count, data: squareData, shapeType: "square")
        }
        
        if let line = shape as? Line {
            let lineData = line.toJsonData()
            return Command(header: ChatRequestTyoe.chat.rawValue, id: userId!, length: lineData?.count, data: lineData, shapeType: "line")
        }
        
        return nil
    }
    
    func convertToShape(command: Command) throws -> Shape? {
        guard let shapeData = command.data else {
            throw ChatCommandError.commandDataIsNil
        }
        
        if command.shapeType == "line" {
            guard let line = try? JSONDecoder().decode(Line.self, from: shapeData) else {
                throw ChatCommandError.failToDecodeLineData
            }
            return line
        } else if command.shapeType == "square" {
            guard let square = try? JSONDecoder().decode(Square.self, from: shapeData) else {
                throw ChatCommandError.failToDecodeSquareData
            }
            return square
        }
        return nil
    }
}
