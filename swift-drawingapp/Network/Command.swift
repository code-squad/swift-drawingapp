//
//  Command.swift
//  swift-drawingapp
//
//  Created by 김상진 on 2022/10/23.
//

import Foundation

struct Command : Codable {
    let header : String
    let id : String
    let length : Int? = nil
    let data : Data?
    
    func toJsonString() -> String? {
        if let jsonData = try? JSONEncoder().encode(self) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }
        return nil
    }
    
    func toJsonData() -> Data? {
        if let jsonData = try? JSONEncoder().encode(self) {
            return jsonData
        }
        return nil
    }
}
