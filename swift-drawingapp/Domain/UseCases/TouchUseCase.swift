//
//  TouchUseCase.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/10/29.
//

import Foundation

protocol TouchUseCase {
    func touch(index: Int, coordinate: Point?)
}
