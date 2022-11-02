//
//  Picture.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol Picture: Identifiable {
    var color: Color { get }
    var points: [Point] { get }
    var lineWidth: Double { get }

    func selected(on location: Point?)
}
