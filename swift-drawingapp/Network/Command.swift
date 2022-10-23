//
//  Command.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/23.
//

import Foundation

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
