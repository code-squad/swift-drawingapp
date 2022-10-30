//
//  Stroke.swift
//  swift-drawingapp
//
//  Created by Haeseok Lee on 2022/10/17.
//

import Foundation

final class Stroke: Item {
    
    var points: [Point]
    
    var ink: Ink
    
    init(id: String = UUID().uuidString, positions: [Point] = [], ink: Ink) {
        self.points = positions
        self.ink = ink
        super.init(id: id, layoutInfo: nil, uiInfo: nil)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case points
        case ink
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        let id = (try? container?.decodeIfPresent(String.self, forKey: .id)) ?? UUID().uuidString
        let points = (try? container?.decodeIfPresent([Point].self, forKey: .points)) ?? []
        let ink = (try? container?.decodeIfPresent(Ink.self, forKey: .ink)) ?? .default
        self.points = points
        self.ink = ink
        super.init(id: id, layoutInfo: nil, uiInfo: nil)
    }
}
