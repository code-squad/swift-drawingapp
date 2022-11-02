//
//  PictureViewModel.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol PictureViewModel {
    var color: Color { get }
    var points: [Point] { get }
    var lineWidth: Double { get }

    func selected(at point: Point?)
}
