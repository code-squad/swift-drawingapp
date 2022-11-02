//
//  DataOutPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol DataOutPort: AnyObject {
    func login() async -> Bool
    func sendPictures(_ pictures: [Picture])
}
