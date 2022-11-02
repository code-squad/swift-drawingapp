//
//  TouchPresenterOutPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol TouchPresenterOutPort: AnyObject {
    func touch(index: Int, at location: Point?)
}
