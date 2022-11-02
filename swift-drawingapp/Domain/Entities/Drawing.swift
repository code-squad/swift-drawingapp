//
//  Drawing.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

final class Drawing: Picture {
    override func selected(on location: Point?) {
        guard let location else { return }
        addPoint(location)
    }
}
