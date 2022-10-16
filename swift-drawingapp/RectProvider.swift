//
//  RectProvider.swift
//  swift-drawingapp
//
//  Created by jaeyoung Yun on 2022/10/16.
//

import Foundation

protocol RectProvidable {
    func createRect() -> Rect
}

final class RectProvider: RectProvidable {
    var rectDict: [UUID: Rect] = .init()

    func createRect() -> Rect {
        let id = UUID()
        let rect = Rect(id: id)
        rectDict[id] = rect

        return rect
    }
}
