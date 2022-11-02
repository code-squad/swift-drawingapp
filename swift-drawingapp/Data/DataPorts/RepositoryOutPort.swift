//
//  RepositoryOutPort.swift
//  swift-drawingapp
//
//  Created by taehyeon.lee on 2022/11/02.
//

import Foundation

protocol RepositoryOutPort: AnyObject {
    func save(pictures: [Picture])
}
