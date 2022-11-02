//
//  NetworkOutPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol NetworkOutPort: AnyObject {
    func login() async -> Bool
}
