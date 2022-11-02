//
//  TouchPresenterInPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol TouchPresenterInPort: AnyObject {
    func touch(index: Int, coordinate: Point?)
}
